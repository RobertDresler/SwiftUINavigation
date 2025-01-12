import SwiftUI
import Combine

@MainActor open class NavigationNode: ObservableObject {

    // MARK: Open

    open var view: AnyView {
        AnyView(EmptyView())
    }

    open var isWrapperNode: Bool { true }
    open var childrenPublishers: [AnyPublisher<[NavigationNode], Never>] {
        let presentedNodePublisher = $presentedNode.map { [$0?.node] }
            .map { $0.compactMap { $0 } }
            .eraseToAnyPublisher()
        return [presentedNodePublisher]
    }

    open func executeCommand(_ command: NavigationCommand) {
        command.execute(on: self)
    }

    open func canExecuteCommand(_ command: NavigationCommand) -> Bool {
        command.canExecute(on: self)
    }

    // MARK: Public

    public typealias MessageListener = (NavigationMessage) -> Void

    public let id: String
    @Published public var presentedNode: (any PresentedNavigationNode)?
    public weak var parent: NavigationNode?
    public var children: [NavigationNode] { _childrenPublisher.value }

    public var root: NavigationNode {
        parent?.root ?? self
    }

    public var predecessors: [NavigationNode] {
        parent?.predecessorsIncludingSelf ?? []
    }

    public var predecessorsIncludingSelf: [NavigationNode] {
        (parent?.predecessorsIncludingSelf ?? []) + [self]
    }

    public var successors: [NavigationNode] {
        children.flatMap(\.successorsIncludingSelf)
    }

    public var successorsIncludingSelf: [NavigationNode] {
        [self] + children.flatMap(\.successorsIncludingSelf)
    }

    public var canPresentIfWouldnt: Bool {
        parent?.isWrapperNode == false || parent?.presentedNode?.node === self
    }

    public var nearestNodeWhichCanPresent: NavigationNode? {
        nearestChildrenNodeWhichCanPresent ?? nearestNodeWhichCanPresentFromParent?.topPresented
    }

    public var topPresented: NavigationNode {
        if let presentedNode = presentedNode?.node {
            presentedNode.topPresented
        } else {
            self
        }
    }

    public var nearestChildrenNodeWhichCanPresent: NavigationNode? {
        let childrenNodesWhichCanPresent = childrenNodesWhichCanPresent
        return childrenNodesWhichCanPresent.compactMap { $0.presentedNode?.node }.first?.nearestChildrenNodeWhichCanPresent
            ?? childrenNodesWhichCanPresent.last
    }

    public func addMessageListener(_ listener: MessageListener?) {
        guard let listener else { return }
        messageListeners.append(listener)
    }

    public func sendMessage(_ message: NavigationMessage) {
        messageListeners.forEach { listener in
            listener(message)
        }
    }

    public func sendRemovalMessage() {
        sendMessage(RemovalNavigationMessage())
    }

    public func sendEnvironmentTrigger(_ trigger: NavigationEnvironmentTrigger) {
        navigationEnvironmentTrigger.send(trigger)
    }

    // MARK: Internal

    let navigationEnvironmentTrigger = PassthroughSubject<NavigationEnvironmentTrigger, Never>()
    var cancellables = Set<AnyCancellable>()

    var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.defaultDeepLinkHandler
    }

    func setDefaultDeepLinkHandler(_ handler: NavigationDeepLinkHandler?) {
        _defaultDeepLinkHandler = handler
    }

    // MARK: Private

    private var _defaultDeepLinkHandler: NavigationDeepLinkHandler?
    private var _childrenPublisher = CurrentValueSubject<[NavigationNode], Never>([])
    private let debugPrintPrefix: String
    private var messageListeners = [MessageListener]()

    @MainActor
    public init() {
        self.id = UUID().uuidString
        debugPrintPrefix = "[\(type(of: self)) \(id.prefix(3))...]"
        printDebugText("Init")
        bind()
    }

    deinit {
        printDebugText("Deinit")
    }

    // MARK: Public Methods

    nonisolated
    public func printDebugText(_ text: String) {
        let debugPrintPrefix = debugPrintPrefix
        Task { @MainActor in
            guard NavigationConfig.shared.isDebugPrintEnabled else { return }
            print("\(debugPrintPrefix): \(text)")
        }
    }

    public func printDebugGraph() {
        root.printDebugGraphFromExactNode()
    }

}

// MARK: Private Methods

private extension NavigationNode {
    func bind() {
        bindParentLogic()
        bindChildren()
        bindSendingRemovalMessages()
    }

    func bindChildren() {
        childrenPublisher
            .sink { [weak self] in self?._childrenPublisher.send($0) }
            .store(in: &cancellables)
    }

    func bindSendingRemovalMessages() {
        childrenPublisher.zip(childrenPublisher.dropFirst())
            .sink { [weak self] oldChildren, newChildren in
                let removedChildren = oldChildren.filter { oldChild in
                    !newChildren.contains(where: { oldChild === $0 })
                }
                removedChildren.forEach { child in
                    child.successorsIncludingSelf.forEach { node in
                        node.sendRemovalMessage()
                    }
                }
            }
            .store(in: &cancellables)
    }

    func bindParentLogic() {
        childrenPublisher
            .sink { [weak self] nodes in
                guard let self else { return }
                nodes.forEach { $0.parent = self }
            }
            .store(in: &cancellables)
    }

    var childrenPublisher: AnyPublisher<[NavigationNode], Never> {
        guard let firstPublisher = childrenPublishers.first else {
            return Just([]).eraseToAnyPublisher()
        }
        return childrenPublishers.dropFirst().reduce(firstPublisher) { combinedPublisher, nextPublisher in
            combinedPublisher.combineLatest(nextPublisher)
                .map { $0 + $1 }
                .eraseToAnyPublisher()
        }
    }

    var nearestNodeWhichCanPresentFromParent: NavigationNode? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    var childrenNodesWhichCanPresent: [NavigationNode] {
        var nodes = [NavigationNode]()
        if canPresentIfWouldnt {
            nodes.append(self)
        }
        nodes += children.flatMap { $0.childrenNodesWhichCanPresent }
        return nodes
    }
}

// MARK: Debug Print

private extension NavigationNode {
    func printDebugGraphFromExactNode(level: Int = 0) {
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugPrintPrefix)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.printDebugGraphFromExactNode(level: level + 1)
            }
        }
    }
}

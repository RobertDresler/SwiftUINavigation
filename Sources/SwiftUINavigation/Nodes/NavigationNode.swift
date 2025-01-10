import SwiftUI
import Combine

@MainActor open class NavigationNode: ObservableObject {

    // MARK: Open

    open var view: AnyView {
        AnyView(EmptyView())
    }

    open var isWrapperNode: Bool { false }
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

    public var canPresentIfWouldnt: Bool {
        parent?.isWrapperNode == false
    }

    public var nearestNodeWhichCanPresent: NavigationNode? {
        nearestNodeWhichCanPresentFromParent?.topPresented ?? nearestChildrenNodeWhichCanPresent
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

    // MARK: Internal

    let urlToOpen = PassthroughSubject<URL, Never>()

    // MARK: Private

    private var cancellables = Set<AnyCancellable>()
    var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.defaultDeepLinkHandler
    }
    private var _defaultDeepLinkHandler: NavigationDeepLinkHandler?
    private var _childrenPublisher = CurrentValueSubject<[NavigationNode], Never>([])
    private let debugPrintPrefix: String

    @MainActor
    public init(defaultDeepLinkHandler: NavigationDeepLinkHandler? = nil) {
        self.id = UUID().uuidString
        _defaultDeepLinkHandler = defaultDeepLinkHandler
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
    }

    func bindChildren() {
        childrenPublisher
            .sink { [weak self] in self?._childrenPublisher.send($0) }
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

import SwiftUI
import Combine

open class NavigationNodeState: ObservableObject {

    // MARK: Published

    @MainActor @Published var presentedNode: (any PresentedNavigationNode)?

    // MARK: Stored

    public let id: String = UUID().uuidString
    weak var parent: (any NavigationNode)?
    var cancellables = Set<AnyCancellable>()
    var _defaultDeepLinkHandler: NavigationDeepLinkHandler?
    var messageListeners = [NavigationMessageListener]()
    var debugPrintPrefix: String?
    var didStart = false
    let _childrenPublisher = CurrentValueSubject<[any NavigationNode], Never>([])
    let navigationEnvironmentTrigger = PassthroughSubject<NavigationEnvironmentTrigger, Never>()
    private var didSendRemovalMessage = false

    // MARK: Getters

    var children: [any NavigationNode] { _childrenPublisher.value }

    @MainActor open var childrenPublishers: [any Publisher<[NavigationNode], Never>] {
        let presentedNodePublisher = $presentedNode.map { [$0?.node] }
            .map { $0.compactMap { $0 } }
        return [presentedNodePublisher]
    }

    @MainActor var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.state.defaultDeepLinkHandler
    }

    // MARK: Lifecycle

    public init() {}

    deinit {
        printDebugText("Deinit")
    }

    // MARK: Internal Methods

    @MainActor func bind(with thisStateNode: any NavigationNode) {
        debugPrintPrefix = "[\(type(of: thisStateNode)) \(id.prefix(3))...]"
        printDebugText("Init")
        bindParentLogic(with: thisStateNode)
        bindChildren()
        bindSendingRemovalMessages()
    }

    func setDefaultDeepLinkHandler(_ handler: NavigationDeepLinkHandler?) {
        _defaultDeepLinkHandler = handler
    }

    func addMessageListener(_ listener: NavigationMessageListener?) {
        guard let listener else { return }
        messageListeners.append(listener)
    }

    func sendMessage(_ message: NavigationMessage) {
        messageListeners.forEach { listener in
            listener(message)
        }
    }

    func sendRemovalMessage() {
        guard !didSendRemovalMessage else { return }
        didSendRemovalMessage = true
        sendMessage(RemovalNavigationMessage())
    }

    func sendEnvironmentTrigger(_ trigger: NavigationEnvironmentTrigger) {
        navigationEnvironmentTrigger.send(trigger)
    }

    nonisolated
    func printDebugText(_ text: String) {
        guard let debugPrintPrefix else { return }
        Task { @MainActor in
            guard NavigationConfig.shared.isDebugPrintEnabled else { return }
            print("\(debugPrintPrefix): \(text)")
        }
    }

    @MainActor func printDebugGraphFromExactNode(level: Int = 0) {
        guard let debugPrintPrefix else { return }
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugPrintPrefix)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.state.printDebugGraphFromExactNode(level: level + 1)
            }
        }
    }

}

// MARK: Private Methods

private extension NavigationNodeState {
    @MainActor func bindChildren() {
        childrenPublisher
            .sink { [weak self] in self?._childrenPublisher.send($0) }
            .store(in: &cancellables)
    }

    @MainActor func bindSendingRemovalMessages() {
        childrenPublisher.zip(childrenPublisher.dropFirst())
            .sink { oldChildren, newChildren in
                let removedChildren = oldChildren.filter { oldChild in
                    !newChildren.contains(where: { oldChild === $0 })
                }
                removedChildren.forEach { child in
                    child.successorsIncludingSelf.forEach { node in
                        node.state.sendRemovalMessage()
                    }
                }
            }
            .store(in: &cancellables)
    }

    @MainActor func bindParentLogic(with thisStateNode: any NavigationNode) {
        childrenPublisher
            .sink { [weak thisStateNode] nodes in
                guard let thisStateNode else { return }
                nodes.forEach { node in
                    node.startIfNeeded()
                    node.state.parent = thisStateNode
                }
            }
            .store(in: &cancellables)
    }

    @MainActor var childrenPublisher: AnyPublisher<[any NavigationNode], Never> {
        guard let firstPublisher = childrenPublishers.first else {
            return Just([]).eraseToAnyPublisher()
        }
        return childrenPublishers.dropFirst().reduce(firstPublisher.eraseToAnyPublisher()) { combinedPublisher, nextPublisher in
            combinedPublisher.combineLatest(nextPublisher.eraseToAnyPublisher())
                .map { $0 + $1 }
                .eraseToAnyPublisher()
        }
    }
}

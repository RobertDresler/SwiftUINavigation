import SwiftUI
import Combine

open class NavigationNode: ObservableObject {

    // MARK: Open

    @MainActor
    open var view: AnyView {
        AnyView(EmptyView())
    }

    // MARK: Public

    public let id: String
    @Published public var stackNodes: [NavigationNodeWithStackTransition]?
    // TODO: -RD- implement @Published public var tabsNodes: [NavigationNode]?
    @Published public var presentedNode: (any PresentedNavigationNode)?
    @Published public var switchedNode: NavigationNode?
    public weak var parent: NavigationNode?
    public var childrenPublisher: AnyPublisher<[NavigationNode], Never> { _childrenPublisher.eraseToAnyPublisher() }
    public var children: [NavigationNode] { _childrenPublisher.value }

    public var root: NavigationNode {
        parent?.root ?? self
    }

    public var canPresentIfWouldnt: Bool {
        (parent is StackRootNavigationNode) == false
    }

    // MARK: Internal

    let urlToOpen = PassthroughSubject<URL, Never>()

    // MARK: Private

    private var cancellables = Set<AnyCancellable>()
    private var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.defaultDeepLinkHandler
    }
    private var _defaultDeepLinkHandler: NavigationDeepLinkHandler?
    private var _childrenPublisher = CurrentValueSubject<[NavigationNode], Never>([])

    // TODO: -RD- separate alert since it's not modal
    @Published var alertConfig: AlertConfig?

    public init(
        stackNodes: [NavigationNodeWithStackTransition]? = nil,
        defaultDeepLinkHandler: NavigationDeepLinkHandler? = nil
    ) {
        self.id = UUID().uuidString
        self.stackNodes = stackNodes
        _defaultDeepLinkHandler = defaultDeepLinkHandler
        printDebugText("Init")
        bind()
    }

    deinit {
        printDebugText("Deinit")
    }

    // MARK: Public Methods

    public func printDebugText(_ text: String) {
        print("\(debugPrintPrefix): \(text)")
    }

    // TODO: -RD- make overridable
    open func handleDeepLink(_ deepLink: any NavigationDeepLink) {
        defaultDeepLinkHandler?.handleDeepLink(deepLink, on: self)
    }

    public func printDebugGraph() {
        root.printDebugGraphFromExactNode()
    }

    public func executeCommand(_ command: NavigationNodeCommand) {
        switch command {
        case .append(let destination):
            append(destination)
        case .removeLast(let count):
            removeLast(count)
        case .removeAll:
            removeAll()
        case .alert(let config):
            alertConfig = config
        case .present(let node):
            present(node)
        case .presentOnExactNode(let node):
            presentOnExactNode(node)
        case .dismiss:
            dismiss()
        case let .setRoot(node, clear):
            setRoot(node, clear: clear)
        case .switchNode(let node):
            switchNode(node)
        case .openURL(let url):
            openURL(url)
        }
    }

    // MARK: Internal Methods
    
    func mapStackNodes(
        mappedNodes: ([NavigationNodeWithStackTransition]) -> [NavigationNodeWithStackTransition]
    ) {
        guard let stackNodes else {
            parent?.mapStackNodes(mappedNodes: mappedNodes)
            return
        }
        self.stackNodes = mappedNodes(stackNodes)
    }

}

// MARK: Command Handling
// TODO: -RD- refactor
private extension NavigationNode {
    func append(_ value: NavigationNodeWithStackTransition) {
        mapStackNodes { nodes in
            nodes + [value]
        }
    }

    func present(_ node: any PresentedNavigationNode) {
        nearestNodeWhichCanPresent?.presentOnExactNode(node)
    }

    func presentOnExactNode(_ node: any PresentedNavigationNode) {
        presentedNode = node
    }
    
    var nearestNodeWhichCanPresent: NavigationNode? {
        nearestNodeWhichCanPresentFromParent?.topPresented
    }

    var topPresented: NavigationNode {
        presentedNode?.node.topPresented ?? self
    }

    var nearestNodeWhichCanPresentFromParent: NavigationNode? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    func dismiss() {
        if presentedNode != nil {
            presentedNode = nil
        } else {
            parent?.dismiss()
        }
    }

    func removeLast(_ count: Int = 1) {
        // TODO: -RD- implement path.removeLast(count)
    }

    func removeAll() {
        // TODO: -RD- implement path = NavigationPath()
    }

    func showAlert(_ config: AlertConfig) {
        alertConfig = config
    }

    func openURL(_ url: URL) {
        urlToOpen.send(url)
    }

    func setRoot(_ newRoot: NavigationNode, clear: Bool) {
        let newRootStackDeepLink = NavigationNodeWithStackTransition(
            destination: newRoot,
            transition: nil
        )
        mapStackNodes { nodes in
            if clear || nodes.isEmpty {
                return [newRootStackDeepLink]
            } else {
                var newNodes = nodes
                newNodes.removeFirst()
                return [newRootStackDeepLink] + newNodes
            }
        }
    }

    func switchNode(_ node: NavigationNode) {
        switchedNode = node
    }
}

// MARK: Private Methods

private extension NavigationNode {
    func bind() {
        bindParentLogic()
        bindChildren()
    }

    func bindChildren() {
        $stackNodes.compactMap { $0?.map(\.destination) }
            .merge(
                with: $presentedNode.map { [$0?.node] },
                $switchedNode.map { [$0] }
            )
            .map { $0.compactMap { $0 } }
            .subscribe(_childrenPublisher)
            .store(in: &cancellables)
    }

    func bindParentLogic() {
        // TODO: @Published var tabsNodes: [SwiftUINavigationNode]?
        childrenPublisher
            .sink { [weak self] nodes in
                guard let self else { return }
                nodes.forEach { $0.parent = self }
            }
            .store(in: &cancellables)
    }
}

// MARK: Debug Print

private extension NavigationNode {
    var debugPrintPrefix: String {
        "[\(type(of: self)) \(id)]"
    }

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

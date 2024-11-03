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
    @Published public var presentedSheetNode: NavigationNode?
    @Published public var switchedNode: NavigationNode?
    public weak var parent: NavigationNode?
    public var childrenPublisher: AnyPublisher<[NavigationNode], Never> {
        $stackNodes.compactMap { $0?.map(\.destination) }
            .merge(
                with: $presentedSheetNode.map { [$0] },
                $switchedNode.map { [$0] }
            )
            .map { $0.compactMap { $0 }}
            .eraseToAnyPublisher()
    }

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
        bindParentLogic()
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
        case .presentSheet(let destination):
            presentSheet(destination)
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
    public func append(_ value: NavigationNodeWithStackTransition) {
        mapStackNodes { nodes in
            nodes + [value]
        }
    }

    public func presentSheet(_ value: NavigationNode) {
        nearestNodeWhichCanPresent?.presentSheetOnExactNode(value)
    }

    public func dismiss() {
        if presentedSheetNode != nil {
            presentedSheetNode = nil
        } else {
            parent?.dismiss()
        }
    }

    public func removeLast(_ count: Int = 1) {
        // TODO: -RD- implement path.removeLast(count)
    }

    public func removeAll() {
        // TODO: -RD- implement path = NavigationPath()
    }

    public func showAlert(_ config: AlertConfig) {
        alertConfig = config
    }

    public func openURL(_ url: URL) {
        urlToOpen.send(url)
    }

    public func setRoot(_ newRoot: NavigationNode, clear: Bool) {
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
    func bindParentLogic() {
        // TODO: @Published var tabsNodes: [SwiftUINavigationNode]?
        childrenPublisher
            .sink { [weak self] nodes in
                guard let self else { return }
                nodes.forEach { $0.parent = self }
            }
            .store(in: &cancellables)
    }

    func presentSheetOnExactNode(_ value: NavigationNode) {
        presentedSheetNode = StackRootNavigationNode(
            stackNodes: [NavigationNodeWithStackTransition(destination: value, transition: nil)]
        )
    }
    var nearestNodeWhichCanPresent: NavigationNode? {
        nearestNodeWhichCanPresentFromParent?.topPresented
    }

    var topPresented: NavigationNode {
        presentedSheetNode?.topPresented ?? self
    }

    var nearestNodeWhichCanPresentFromParent: NavigationNode? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    var children: [NavigationNode] {
        (
            [presentedSheetNode]
            + [switchedNode]
            + (stackNodes?.map(\.destination) ?? [])
        ).compactMap { $0 }
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

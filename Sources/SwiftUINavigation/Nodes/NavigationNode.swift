import SwiftUI
import Combine

open class NavigationNode: ObservableObject {

    @Published var stackNodes: [SwiftUINavigationNodeWithStackTransition]?
    @Published var tabsNodes: [NavigationNode]?
    // TODO: -RD- separate alert since it's not modal
    @Published var alertConfig: AlertConfig?
    @Published public var presentedSheetNode: NavigationNode?
    @Published public var switchedNode: NavigationNode?
    public let urlToOpen = PassthroughSubject<URL, Never>()
    private var cancellables = Set<AnyCancellable>()
    public var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.defaultDeepLinkHandler
    }
    public var _defaultDeepLinkHandler: NavigationDeepLinkHandler?

    public weak var parent: NavigationNode?
    private var root: NavigationNode {
        parent?.root ?? self
    }

    public let id: String

    // TODO: -RD- make type more dependent on resolved view - e.g. if you want switched, subclass switched
    public init(
        stackNodes: [SwiftUINavigationNodeWithStackTransition]? = nil,
        defaultDeepLinkHandler: NavigationDeepLinkHandler? = nil
    ) {
        self.id = UUID().uuidString
        self.stackNodes = stackNodes == nil ? nil : []
        _defaultDeepLinkHandler = defaultDeepLinkHandler
        printDebugText("Init")
        if let stackNodes {
            mapStackNodes { _ in
                stackNodes
            }
        }
        bindParentLogic()
    }

    deinit {
        printDebugText("Deinit")
    }

    func bindParentLogic() {
        // TODO: @Published var tabsNodes: [SwiftUINavigationNode]?
        // TODO: -RD- merge
        $stackNodes
            .compactMap { $0 }
            .sink { [weak self] nodes in
                guard let self else { return }
                nodes.forEach { $0.destination.parent = self }
            }
            .store(in: &cancellables)

        $presentedSheetNode
            .compactMap { $0 }
            .sink { [weak self] node in
                guard let self else { return }
                node.parent = self
            }
            .store(in: &cancellables)

        $switchedNode
            .compactMap { $0 }
            .sink { [weak self] node in
                guard let self else { return }
                node.parent = self
            }
            .store(in: &cancellables)
    }

    public func printDebugText(_ text: String) {
        print("\(debugPrintPrefix): \(text)")
    }

    private var debugPrintPrefix: String {
        "[\(type(of: self)) \(id)]"
    }

    @MainActor
    open var view: AnyView {
        AnyView(EmptyView())
    }

    // TODO: -RD- make overridable
    public func handleDeepLink(_ deepLink: any NavigationDeepLink) {
        defaultDeepLinkHandler?.handleDeepLink(deepLink, on: self)
    }

    public func append(_ value: SwiftUINavigationNodeWithStackTransition) {
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

    public var canPresentIfWouldnt: Bool {
        (parent is StackRootNavigationNode) == false
    }

    public func setRoot(_ newRoot: NavigationNode, clear: Bool) {
        let newRootStackDeepLink = SwiftUINavigationNodeWithStackTransition(
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

    func mapStackNodes(
        mappedNodes: ([SwiftUINavigationNodeWithStackTransition]) -> [SwiftUINavigationNodeWithStackTransition]
    ) {
        guard let stackNodes else {
            parent?.mapStackNodes(mappedNodes: mappedNodes)
            return
        }
        self.stackNodes = mappedNodes(stackNodes)
    }

    func switchNode(_ node: NavigationNode) {
        switchedNode = node
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

}

// MARK: Command Handling

private extension NavigationNode {
}

// MARK: Private Methods

private extension NavigationNode {
    func presentSheetOnExactNode(_ value: NavigationNode) {
        presentedSheetNode = StackRootNavigationNode(
            stackNodes: [SwiftUINavigationNodeWithStackTransition(destination: value, transition: nil)]
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

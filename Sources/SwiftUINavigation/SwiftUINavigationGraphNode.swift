import SwiftUI

public final class SwiftUINavigationGraphNode<DeepLink: NavigationDeepLink>: ObservableObject {

    enum NodeType {
        case root
        case standalone
        case stackRoot
        case stack
        case switchedNode
    }

    // TODO: -RD- separate
    public enum Command {
        case append(StackDeepLink<DeepLink>)
        case removeLast(count: Int = 1)
        case removeAll
        case alert(AlertConfig)
        case presentSheet(DeepLink)
        case dismiss
        case setRoot(DeepLink, clear: Bool)
        case switchNode(DeepLink)
    }

    struct NodeStackDeepLink {

        let destination: SwiftUINavigationGraphNode<DeepLink>
        let transition: StackDeepLink<DeepLink>.Transition?

        var toStackDeepLink: StackDeepLink<DeepLink>? {
            guard let deepLink = destination.wrappedDeepLink else { return nil }
            return StackDeepLink(destination: deepLink, transition: transition)
        }

    }

    @Published public var wrappedDeepLink: DeepLink?
    @Published var stackNodes: [NodeStackDeepLink]?
    // TODO: -RD- separate alert since it's not modal
    @Published var alertConfig: AlertConfig?
    @Published public var presentedSheetNode: SwiftUINavigationGraphNode<DeepLink>?
    @Published public var switchedNodeDeepLink: DeepLink?
    public var directChildNodeReference: SwiftUINavigationGraphNode<DeepLink>?

    private var _openURL: ((URL) -> Void)?

    public weak var parent: SwiftUINavigationGraphNode<DeepLink>?
    private let type: NodeType
    private var root: SwiftUINavigationGraphNode<DeepLink> {
        parent?.root ?? self
    }

    init(
        type: NodeType,
        wrappedDeepLink: DeepLink?,
        parent: SwiftUINavigationGraphNode<DeepLink>?,
        stackNodes: [StackDeepLink<DeepLink>]? = nil
    ) {
        self.type = type
        self.wrappedDeepLink = wrappedDeepLink
        self.parent = parent
        self.stackNodes = stackNodes == nil ? nil : []
        if let stackNodes {
            mapStackNodes { _ in stackNodes }
        }
        if [.root, .switchedNode].contains(parent?.type) {
            parent?.directChildNodeReference = self
        }
    }

    public func setOpenURL(_ openURL: @escaping (URL) -> Void) {
        self._openURL = openURL
    }

    public func append(_ value: StackDeepLink<DeepLink>) {
        mapStackNodes { nodes in
            nodes + [value]
        }
    }

    public func presentSheet(_ value: DeepLink) {
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
        _openURL?(url)
    }

    public func setRoot(_ newRoot: DeepLink, clear: Bool) {
        let newRootStackDeepLink = StackDeepLink(destination: newRoot)
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

    func mapStackNodes(mappedNodes: ([StackDeepLink<DeepLink>]) -> [StackDeepLink<DeepLink>]) {
        guard let stackNodes else {
            parent?.mapStackNodes(mappedNodes: mappedNodes)
            return
        }
        self.stackNodes = mappedNodes(
            stackNodes.compactMap { $0.toStackDeepLink }
        ).map { deepLink in
            NodeStackDeepLink(
                destination: SwiftUINavigationGraphNode(type: .stack, wrappedDeepLink: deepLink.destination, parent: self),
                transition: deepLink.transition
            )
        }
    }

    func switchNode(_ deepLink: DeepLink) {
        switchedNodeDeepLink = deepLink
    }

    public func printDebugGraph() {
        root.printDebugGraphFromExactNode()
    }

    public func executeCommand(_ command: Command) {
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
        case let .setRoot(deepLink, clear):
            setRoot(deepLink, clear: clear)
        case .switchNode(let deepLink):
            switchNode(deepLink)
        }
    }

}

// MARK: Private Methods

private extension SwiftUINavigationGraphNode {
    func presentSheetOnExactNode(_ value: DeepLink) {
        presentedSheetNode = SwiftUINavigationGraphNode(
            type: .stackRoot,
            wrappedDeepLink: value,
            parent: self,
            stackNodes: [StackDeepLink(destination: value)]
        )
    }
    var nearestNodeWhichCanPresent: SwiftUINavigationGraphNode<DeepLink>? {
        nearestNodeWhichCanPresentFromParent?.topPresented
    }

    var topPresented: SwiftUINavigationGraphNode<DeepLink> {
        presentedSheetNode?.topPresented ?? self
    }

    var nearestNodeWhichCanPresentFromParent: SwiftUINavigationGraphNode<DeepLink>? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    var canPresentIfWouldnt: Bool {
        type != .stack
    }

    var children: [SwiftUINavigationGraphNode<DeepLink>] {
        (
            [directChildNodeReference]
            + [presentedSheetNode]
            + (stackNodes?.map(\.destination) ?? [])
        ).compactMap { $0 }
    }

    func printDebugGraphFromExactNode(level: Int = 0) {
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugGraphNameForPrint)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.printDebugGraphFromExactNode(level: level + 1)
            }
        }
    }

    var debugGraphNameForPrint: String {
        if let debugName = wrappedDeepLink?.debugName {
            "\(type) - \(debugName)"
        } else {
            "\(type)"
        }

    }
}

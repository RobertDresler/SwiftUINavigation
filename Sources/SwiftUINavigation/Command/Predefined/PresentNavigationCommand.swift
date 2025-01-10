public struct PresentNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let presenterNode = presenterNode(for: node) else { return }
        executableCommand.execute(on: presenterNode)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        guard let presenterNode = presenterNode(for: node) else { return false }
        return executableCommand.canExecute(on: node)
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
    }

    private var executableCommand: NavigationCommand {
        PresentOnGivenNodeNavigationCommand(
            presentedNode: presentedNode,
            animated: animated
        )
    }

    /// If `sourceID` is not `nil`, `presentedNode` is presented on the `node` from `execude(_on:)` since we want to present from
    /// `presenterResolvedViewModifier(presentedNode:content:sourceID:)` on that source view
    private func presenterNode(for node: NavigationNode) -> NavigationNode? {
        presentedNode.sourceID == nil ? node.nearestNodeWhichCanPresent : node
    }

}

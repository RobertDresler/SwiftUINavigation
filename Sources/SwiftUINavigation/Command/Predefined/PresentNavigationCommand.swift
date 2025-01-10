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

    private func presenterNode(for node: NavigationNode) -> NavigationNode? {
        node.nearestNodeWhichCanPresent
    }

}

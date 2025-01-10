public struct PresentNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        executableCommand(on: node)?.execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        executableCommand(on: node)?.canExecute(on: node) ?? false
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
    }

    private func executableCommand(on node: NavigationNode) -> NavigationCommand? {
        guard let presenterNode = node.nearestNodeWhichCanPresent else { return nil }
        return PresentOnGivenNodeNavigationCommand(
            presentedNode: presentedNode,
            animated: animated
        )
    }

}

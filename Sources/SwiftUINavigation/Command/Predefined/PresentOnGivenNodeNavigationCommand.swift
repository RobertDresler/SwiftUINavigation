public struct PresentOnGivenNodeNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        perform(
            animated: animated,
            action: { node.presentedNode = presentedNode }
        )
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        true
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
    }

}

public struct PresentOnGivenNodeNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        perform(
            animated: animated,
            action: { node.presentedNode = presentedNode }
        )
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
    }

}

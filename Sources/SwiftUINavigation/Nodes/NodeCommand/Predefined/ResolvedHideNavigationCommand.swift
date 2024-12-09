public struct ResolvedHideNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        if (node.parent as? StackRootNavigationNode)?.stackNodes.first?.destination === node {
            DismissNavigationCommand(animated: animated).execute(on: node)
        } else {
            StackDropLastNavigationCommand(animated: animated).execute(on: node)
        }
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

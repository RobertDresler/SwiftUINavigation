public struct ResolvedHideNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        resolvedCommand(on: node).execute(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        resolvedCommand(on: node).canExecute(on: node)
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    private func resolvedCommand(on node: any NavigationNode) -> NavigationCommand {
        if (node.parent?.state as? StackRootNavigationNodeState)?.stackNodes.first?.destination === node {
            DismissNavigationCommand(animated: animated)
        } else {
            StackDropLastNavigationCommand(animated: animated)
        }
    }

}

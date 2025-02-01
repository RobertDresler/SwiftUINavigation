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
        if (node.parent as? any StackRootNavigationNode)?.stackNodes.first?.destination === node {
            .dismiss(animated: animated)
        } else {
            .stackDropLast(animated: animated)
        }
    }

}

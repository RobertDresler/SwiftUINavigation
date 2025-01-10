public struct ResolvedHideNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        resolvedCommand(on: node).execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        resolvedCommand(on: node).canExecute(on: node)
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    private func resolvedCommand(on node: NavigationNode) -> NavigationCommand {
        if (node.parent as? StackRootNavigationNode)?.stackNodes.first?.destination === node {
            DismissNavigationCommand(animated: animated)
        } else {
            StackDropLastNavigationCommand(animated: animated)
        }
    }

}

public struct StackAppendNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let appendedNode: StackNavigationNode
    private let animated: Bool

    public init(appendedNode: StackNavigationNode, animated: Bool = true) {
        self.appendedNode = appendedNode
        self.animated = animated
    }

    public init(appendedNode: any NavigationNode, animated: Bool = true) {
        self.appendedNode = StackNavigationNode(destination: appendedNode)
        self.animated = animated
    }

    private func stackMapCommand(for node: any NavigationNode) -> NavigationCommand {
        .stackMap(
            { nodes in
                nodes + [appendedNode]
            },
            animated: animated
        )
    }

}

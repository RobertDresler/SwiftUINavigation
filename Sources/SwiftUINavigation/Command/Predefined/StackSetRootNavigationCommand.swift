public struct StackSetRootNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let rootNode: any NavigationNode
    private let clear: Bool
    private let animated: Bool

    public init(rootNode: any NavigationNode, clear: Bool, animated: Bool = true) {
        self.rootNode = rootNode
        self.clear = clear
        self.animated = animated
    }

    private func stackMapCommand(for node: any NavigationNode) -> NavigationCommand {
        .stackMap(
            { nodes in
                let rootNodeWithStackTransition = StackNavigationNode(
                    destination: rootNode,
                    transition: nil
                )
                if clear || nodes.isEmpty {
                    return [rootNodeWithStackTransition]
                } else {
                    var newNodes = nodes
                    newNodes.removeFirst()
                    return [rootNodeWithStackTransition] + newNodes
                }
            },
            animated: animated
        )
    }

}

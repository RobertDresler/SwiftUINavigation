public struct StackSetRootNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let rootNode: NavigationNode
    private let clear: Bool
    private let animated: Bool

    public init(rootNode: NavigationNode, clear: Bool, animated: Bool = true) {
        self.rootNode = rootNode
        self.clear = clear
        self.animated = animated
    }

    private func stackMapCommand(for node: NavigationNode) -> NavigationCommand {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
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
            }
        )
    }

}

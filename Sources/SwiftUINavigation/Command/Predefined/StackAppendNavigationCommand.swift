public struct StackAppendNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let appendedNode: StackNavigationNode
    private let animated: Bool

    public init(appendedNode: StackNavigationNode, animated: Bool = true) {
        self.appendedNode = appendedNode
        self.animated = animated
    }

    public init(appendedNode: NavigationNode, animated: Bool = true) {
        self.appendedNode = StackNavigationNode(destination: appendedNode)
        self.animated = animated
    }

    private func stackMapCommand(for node: NavigationNode) -> NavigationCommand {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                nodes + [appendedNode]
            }
        )
    }

}

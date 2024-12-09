public struct StackAppendNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                nodes + [appendedNode]
            }
        ).execute(on: node)
    }

    private let appendedNode: StackNavigationNode
    private let animated: Bool

    public init(appendedNode: StackNavigationNode, animated: Bool = true) {
        self.appendedNode = appendedNode
        self.animated = animated
    }

}

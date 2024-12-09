public struct StackDropLastNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                nodes.dropLast(k)
            }
        ).execute(on: node)
    }

    private let k: Int
    private let animated: Bool

    public init(k: Int = 1, animated: Bool = true) {
        self.k = k
        self.animated = animated
    }

}

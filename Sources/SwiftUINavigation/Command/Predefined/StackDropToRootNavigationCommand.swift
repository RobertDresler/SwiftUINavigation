public struct StackDropToRootNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    private func stackMapCommand(for node: NavigationNode) -> NavigationCommand {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                Array(nodes.prefix(1))
            }
        )
    }

}

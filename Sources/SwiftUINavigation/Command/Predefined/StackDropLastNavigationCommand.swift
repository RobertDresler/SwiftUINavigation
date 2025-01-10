public struct StackDropLastNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let k: UInt
    private let animated: Bool

    public init(k: UInt = 1, animated: Bool = true) {
        self.k = k
        self.animated = animated
    }

    private func stackMapCommand(for node: NavigationNode) -> NavigationCommand {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                nodes.dropLast(min(Int(k), nodes.count - 1))
            }
        )
    }

}

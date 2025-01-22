public struct StackMapNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        mapStackNodes(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains(where: { $0.state is StackRootNavigationNodeState })
    }

    private let animated: Bool
    private let transform: ([StackNavigationNode]) -> [StackNavigationNode]

    public init(
        animated: Bool,
        transform: @escaping ([StackNavigationNode]) -> [StackNavigationNode]
    ) {
        self.animated = animated
        self.transform = transform
    }

    private func mapStackNodes(on node: any NavigationNode) {
        guard let state = node.state as? StackRootNavigationNodeState else {
            if let parent = node.parent {
                return mapStackNodes(on: parent)
            } else {
                return
            }
        }
        setMappedNodes(for: state)
    }

    private func setMappedNodes(for state: StackRootNavigationNodeState) {
        perform(
            animated: animated,
            action: {
                state.stackNodes = transform(state.stackNodes)
            }
        )
    }

}

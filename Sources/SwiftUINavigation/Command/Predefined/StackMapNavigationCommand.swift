public struct StackMapNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        mapStackNodes(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains(where: { $0 is any StackRootNavigationNode })
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
        guard let node = node as? any StackRootNavigationNode else {
            if let parent = node.parent {
                return mapStackNodes(on: parent)
            } else {
                return
            }
        }
        setMappedNodes(for: node)
    }

    private func setMappedNodes(for node: any StackRootNavigationNode) {
        perform(
            animated: animated,
            action: {
                node.stackNodes = transform(node.stackNodes)
            }
        )
    }

}

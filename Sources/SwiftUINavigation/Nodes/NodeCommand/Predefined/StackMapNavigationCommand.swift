public struct StackMapNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        mapStackNodes(on: node)
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

    private func mapStackNodes(on node: NavigationNode) {
        guard let node = node as? StackRootNavigationNode else {
            if let parent = node.parent {
                return mapStackNodes(on: parent)
            } else {
                return
            }
        }
        setMappedNodes(for: node)
    }

    private func setMappedNodes(for node: StackRootNavigationNode) {
        perform(
            animated: animated,
            action: {
                node.stackNodes = transform(node.stackNodes)
            }
        )
    }

}

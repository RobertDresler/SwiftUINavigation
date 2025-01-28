@MainActor
public extension NavigationNode where Self == StackRootNavigationNode {
    static func stacked(_ node: StackNavigationNode) -> StackRootNavigationNode {
        StackRootNavigationNode(stackNodes: [node])
    }

    static func stacked(_ node: any NavigationNode) -> StackRootNavigationNode {
        StackRootNavigationNode(stackNodes: [node])
    }

    static func stacked(_ nodes: [StackNavigationNode]) -> StackRootNavigationNode {
        StackRootNavigationNode(stackNodes: nodes)
    }

    static func stacked(_ nodes: [any NavigationNode]) -> StackRootNavigationNode {
        StackRootNavigationNode(stackNodes: nodes)
    }
}

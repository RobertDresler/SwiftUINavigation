@MainActor
public extension NavigationNode where Self == StackRootNavigationNode {
    static func stacked(
        _ node: StackNavigationNode,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> StackRootNavigationNode {
        .stacked([node], tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ node: any NavigationNode,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> StackRootNavigationNode {
        .stacked([node], tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ nodes: [StackNavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> StackRootNavigationNode {
        StackRootNavigationNode(stackNodes: nodes, tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ nodes: [any NavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> StackRootNavigationNode {
        StackRootNavigationNode(stackNodes: nodes, tabBarToolbarBehavior: tabBarToolbarBehavior)
    }
}

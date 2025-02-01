@MainActor
public extension NavigationNode where Self == DefaultStackRootNavigationNode {
    static func stacked(
        _ node: StackNavigationNode,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationNode {
        .stacked([node], tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ node: any NavigationNode,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationNode {
        .stacked([node], tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ nodes: [StackNavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationNode {
        DefaultStackRootNavigationNode(stackNodes: nodes, tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ nodes: [any NavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationNode {
        DefaultStackRootNavigationNode(stackNodes: nodes, tabBarToolbarBehavior: tabBarToolbarBehavior)
    }
}

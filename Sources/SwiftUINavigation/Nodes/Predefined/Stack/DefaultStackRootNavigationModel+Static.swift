@MainActor
public extension NavigationModel where Self == DefaultStackRootNavigationModel {
    static func stacked(
        _ model: StackNavigationModel,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationModel {
        .stacked([model], tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ model: any NavigationModel,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationModel {
        .stacked([model], tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ models: [StackNavigationModel],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationModel {
        DefaultStackRootNavigationModel(models, tabBarToolbarBehavior: tabBarToolbarBehavior)
    }

    static func stacked(
        _ models: [any NavigationModel],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) -> DefaultStackRootNavigationModel {
        DefaultStackRootNavigationModel(models, tabBarToolbarBehavior: tabBarToolbarBehavior)
    }
}

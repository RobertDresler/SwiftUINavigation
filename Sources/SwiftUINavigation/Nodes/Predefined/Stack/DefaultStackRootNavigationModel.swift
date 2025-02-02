import SwiftUI

@StackRootNavigationModel
public final class DefaultStackRootNavigationModel {

    public var stackModels: [StackNavigationModel]
    public var tabBarToolbarBehavior: StackTabBarToolbarBehavior

    public init(_ stackModels: [StackNavigationModel], tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic) {
        self.stackModels = stackModels
        self.tabBarToolbarBehavior = tabBarToolbarBehavior
    }

    public convenience init(
        _ stackModels: [any NavigationModel],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            stackModels.map { StackNavigationModel(destination: $0) },
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public convenience init(
        _ stackModel: StackNavigationModel,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            [stackModel],
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public convenience init(
        _ stackModel: any NavigationModel,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            [stackModel],
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public func body(for content: StackRootNavigationModelView<DefaultStackRootNavigationModel>) -> some View {
        content
    }

}

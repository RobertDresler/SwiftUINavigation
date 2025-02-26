import SwiftUI

@StackRootNavigationModel
public final class DefaultStackRootNavigationModel {

    public var path: [StackNavigationModel]
    public var tabBarToolbarBehavior: StackTabBarToolbarBehavior

    public init(_ path: [StackNavigationModel], tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic) {
        self.path = path
        self.tabBarToolbarBehavior = tabBarToolbarBehavior
    }

    public convenience init(
        _ path: [any NavigationModel],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            path.map { StackNavigationModel(model: $0) },
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

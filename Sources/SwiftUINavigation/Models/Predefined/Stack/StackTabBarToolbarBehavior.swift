import SwiftUI

public enum StackTabBarToolbarBehavior {
    case automatic
    case hiddenWhenNotRoot(animated: Bool)
}

struct StackTabBarToolbarBehaviorViewModifier<InputNavigationModel: StackRootNavigationModel>: ViewModifier {

    @EnvironmentNavigationModel private var navigationModel: InputNavigationModel

    func body(content: Content) -> some View {
        content
            #if os(iOS)
            .toolbar(tabBarVisibility, for: .tabBar)
            #endif
            .animation(animated ? .default : nil, value: tabBarVisibility)
    }

    private var animated: Bool {
        switch navigationModel.tabBarToolbarBehavior {
        case .automatic:
            false
        case .hiddenWhenNotRoot(let animated):
            animated
        }
    }

    private var tabBarVisibility: Visibility {
        switch navigationModel.tabBarToolbarBehavior {
        case .automatic:
            .automatic
        case .hiddenWhenNotRoot:
            navigationModel.path.count > 1 ? .hidden : .automatic
        }
    }

}

public extension View {
    func handlingStackTabBarToolbarBehavior<InputNavigationModel: StackRootNavigationModel>(
        inputNavigationModelType: InputNavigationModel.Type
    ) -> some View {
        modifier(StackTabBarToolbarBehaviorViewModifier<InputNavigationModel>())
    }
}

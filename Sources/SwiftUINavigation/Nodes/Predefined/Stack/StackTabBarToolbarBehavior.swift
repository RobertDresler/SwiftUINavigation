import SwiftUI

public enum StackTabBarToolbarBehavior {
    case automatic
    case hiddenWhenNotRoot(animated: Bool)
}

struct StackTabBarToolbarBehaviorViewModifier: ViewModifier {

    @EnvironmentNavigationNodeState private var navigationNodeState: StackRootNavigationNodeState

    func body(content: Content) -> some View {
        content
            .toolbar(tabBarVisibility, for: .tabBar)
            .animation(animated ? .default : nil, value: tabBarVisibility)
    }

    private var animated: Bool {
        switch navigationNodeState.tabBarToolbarBehavior {
        case .automatic:
            false
        case .hiddenWhenNotRoot(let animated):
            animated
        }
    }

    private var tabBarVisibility: Visibility {
        switch navigationNodeState.tabBarToolbarBehavior {
        case .automatic:
            .automatic
        case .hiddenWhenNotRoot:
            navigationNodeState.stackNodes.count > 1 ? .hidden : .automatic
        }
    }

}

public extension View {
    func handlingStackTabBarToolbarBehavior() -> some View {
        modifier(StackTabBarToolbarBehaviorViewModifier())
    }
}

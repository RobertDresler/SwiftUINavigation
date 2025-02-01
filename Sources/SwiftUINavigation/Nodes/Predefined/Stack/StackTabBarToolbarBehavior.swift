import SwiftUI

public enum StackTabBarToolbarBehavior {
    case automatic
    case hiddenWhenNotRoot(animated: Bool)
}

struct StackTabBarToolbarBehaviorViewModifier<InputNavigationNode: StackRootNavigationNode>: ViewModifier {

    @EnvironmentNavigationNode private var navigationNode: InputNavigationNode

    func body(content: Content) -> some View {
        content
            .toolbar(tabBarVisibility, for: .tabBar)
            .animation(animated ? .default : nil, value: tabBarVisibility)
    }

    private var animated: Bool {
        switch navigationNode.tabBarToolbarBehavior {
        case .automatic:
            false
        case .hiddenWhenNotRoot(let animated):
            animated
        }
    }

    private var tabBarVisibility: Visibility {
        switch navigationNode.tabBarToolbarBehavior {
        case .automatic:
            .automatic
        case .hiddenWhenNotRoot:
            navigationNode.stackNodes.count > 1 ? .hidden : .automatic
        }
    }

}

public extension View {
    func handlingStackTabBarToolbarBehavior<InputNavigationNode: StackRootNavigationNode>(
        inputNavigationNodeType: InputNavigationNode.Type
    ) -> some View {
        modifier(StackTabBarToolbarBehaviorViewModifier<InputNavigationNode>())
    }
}

import SwiftUI

@StackRootNavigationNode
public final class DefaultStackRootNavigationNode {

    public var stackNodes: [StackNavigationNode]
    public var tabBarToolbarBehavior: StackTabBarToolbarBehavior

    public init(_ stackNodes: [StackNavigationNode], tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic) {
        self.stackNodes = stackNodes
        self.tabBarToolbarBehavior = tabBarToolbarBehavior
    }

    public convenience init(
        _ stackNodes: [any NavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            stackNodes.map { StackNavigationNode(destination: $0) },
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public convenience init(
        _ stackNode: StackNavigationNode,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            [stackNode],
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public convenience init(
        _ stackNode: any NavigationNode,
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            [stackNode],
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public func body(for content: StackRootNavigationNodeView<DefaultStackRootNavigationNode>) -> some View {
        content
    }

}

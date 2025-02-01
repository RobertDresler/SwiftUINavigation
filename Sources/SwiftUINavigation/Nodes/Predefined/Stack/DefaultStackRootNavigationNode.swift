import SwiftUI

@StackRootNavigationNode
public final class DefaultStackRootNavigationNode {

    public var stackNodes: [StackNavigationNode]
    public var tabBarToolbarBehavior: StackTabBarToolbarBehavior

    public init(stackNodes: [StackNavigationNode], tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic) {
        self.stackNodes = stackNodes
        self.tabBarToolbarBehavior = tabBarToolbarBehavior
    }

    public convenience init(
        stackNodes: [any NavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.init(
            stackNodes: stackNodes.map { StackNavigationNode(destination: $0) },
            tabBarToolbarBehavior: tabBarToolbarBehavior
        )
    }

    public func body(for content: StackRootNavigationNodeView<DefaultStackRootNavigationNode>) -> some View {
        content
    }

}

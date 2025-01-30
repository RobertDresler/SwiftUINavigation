import SwiftUI

@StackRootNavigationNode
public class StackRootNavigationNode {

    public init(stackNodes: [StackNavigationNode], tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic) {
        self.state = StackRootNavigationNodeState(stackNodes: stackNodes, tabBarToolbarBehavior: tabBarToolbarBehavior)
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

}

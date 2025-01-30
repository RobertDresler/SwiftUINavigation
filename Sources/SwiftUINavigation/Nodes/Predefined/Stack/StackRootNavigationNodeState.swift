import SwiftUI
import Combine

public class StackRootNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public var stackNodes: [StackNavigationNode]
    @Published public var tabBarToolbarBehavior: StackTabBarToolbarBehavior

    // MARK: Getters

    public override var children: [any NavigationNode] {
        super.children + stackNodes.map(\.destination)
    }

    // MARK: Lifecycle

    public init(
        stackNodes: [StackNavigationNode],
        tabBarToolbarBehavior: StackTabBarToolbarBehavior = .automatic
    ) {
        self.stackNodes = stackNodes
        self.tabBarToolbarBehavior = tabBarToolbarBehavior
    }

    func setNewPath(_ newPath: NavigationPath) {
        stackNodes = Array(stackNodes.prefix(newPath.count + 1))
    }

}

import SwiftUI
import Combine

public protocol StackRootNavigationNode: NavigationNode {
    associatedtype ModifiedView: View
    var stackNodes: [StackNavigationNode] { get set }
    var tabBarToolbarBehavior: StackTabBarToolbarBehavior { get set }
    @ViewBuilder func body(for content: StackRootNavigationNodeView<Self>) -> ModifiedView
}

public extension StackRootNavigationNode {
    var children: [any NavigationNode] {
        baseNavigationNodeChildren + stackNodes.map(\.destination)
    }

    var body: ModifiedView {
        body(for: StackRootNavigationNodeView())
    }

    func setNewPath(_ newPath: NavigationPath) {
        stackNodes = Array(stackNodes.prefix(newPath.count + 1))
    }
}

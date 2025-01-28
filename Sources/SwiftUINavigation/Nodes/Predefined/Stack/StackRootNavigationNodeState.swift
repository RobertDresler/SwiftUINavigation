import SwiftUI
import Combine

public class StackRootNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public var stackNodes: [StackNavigationNode]

    // MARK: Getters

    public override var children: [any NavigationNode] {
        super.children + stackNodes.map(\.destination)
    }

    // MARK: Lifecycle

    public init(stackNodes: [StackNavigationNode]) {
        self.stackNodes = stackNodes
    }

    func setNewPath(_ newPath: NavigationPath) {
        stackNodes = Array(stackNodes.prefix(newPath.count + 1))
    }

}

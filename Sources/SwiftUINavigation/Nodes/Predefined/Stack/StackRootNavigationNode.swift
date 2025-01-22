import SwiftUI

@StackRootNavigationNode
public class StackRootNavigationNode {

    public init(stackNodes: [StackNavigationNode]) {
        self.state = StackRootNavigationNodeState(stackNodes: stackNodes)
    }

    public init(stackNodes: [any NavigationNode]) {
        self.state = StackRootNavigationNodeState(stackNodes: stackNodes.map { StackNavigationNode(destination: $0) })
    }

}

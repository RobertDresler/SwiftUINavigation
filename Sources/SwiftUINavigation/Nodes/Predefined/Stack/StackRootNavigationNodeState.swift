import SwiftUI
import Combine

public class StackRootNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public internal(set) var stackNodes: [StackNavigationNode]

    // MARK: Getters

    public override var childrenPublishers: [any Publisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$stackNodes.map { $0.map { $0.destination } }]
    }

    // MARK: Lifecycle

    public init(stackNodes: [StackNavigationNode]) {
        self.stackNodes = stackNodes
    }

    func setNewPath(_ newPath: NavigationPath) {
        stackNodes = Array(stackNodes.prefix(newPath.count + 1))
    }

}

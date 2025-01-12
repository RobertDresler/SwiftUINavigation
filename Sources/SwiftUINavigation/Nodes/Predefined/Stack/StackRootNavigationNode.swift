import SwiftUI
import Combine

public final class StackRootNavigationNode: NavigationNode {

    @Published public internal(set) var stackNodes: [StackNavigationNode]

    public override var childrenPublishers: [AnyPublisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$stackNodes.map { $0.map { $0.destination } }.eraseToAnyPublisher()]
    }

    public override var view: AnyView {
        AnyView(StackRootNavigationNodeView())
    }

    public init(stackNodes: [StackNavigationNode]) {
        self.stackNodes = stackNodes
        super.init()
    }

    public init(stackNodes: [NavigationNode]) {
        self.stackNodes = stackNodes.map { StackNavigationNode(destination: $0) }
        super.init()
    }

    func setNewPath(_ newPath: NavigationPath) {
        executeCommand(
            StackMapNavigationCommand(
                animated: false,
                transform: { nodes in
                    Array(nodes.prefix(newPath.count + 1))
                }
            )
        )
    }

}

import SwiftUI
import Combine

public final class StackRootNavigationNode: NavigationNode {

    @Published public internal(set) var stackNodes: [StackNavigationNode]
    public override var isWrapperNode: Bool { true }

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

}

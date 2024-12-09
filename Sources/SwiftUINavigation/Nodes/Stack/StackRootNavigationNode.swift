import SwiftUI
import Combine

public final class StackRootNavigationNode: NavigationNode {

    @Published public internal(set) var stackNodes: [StackNavigationNode]
    public override var isWrapperNode: Bool { true }

    public override var childrenPublisher: AnyPublisher<[NavigationNode], Never> {
        super.childrenPublisher
            .merge(with: $stackNodes.map { $0.map { $0.destination } })
            .eraseToAnyPublisher()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(StackRootNavigationNodeView())
    }

    public init(stackNodes: [StackNavigationNode]) {
        self.stackNodes = stackNodes
        super.init()
    }

}

import SwiftUI
import Combine

open class SwitchedNavigationNode: NavigationNode {

    @Published public internal(set) var switchedNode: NavigationNode?

    public override var childrenPublisher: AnyPublisher<[NavigationNode], Never> {
        super.childrenPublisher
            .merge(with: $switchedNode.map { [$0].compactMap { $0} })
            .eraseToAnyPublisher()
    }

    @MainActor
    open override var view: AnyView {
        AnyView(SwitchedNavigationNodeView())
    }

}

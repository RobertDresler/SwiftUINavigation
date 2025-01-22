import SwiftUI
import Combine

open class SwitchedNavigationNode: NavigationNode {

    @Published public internal(set) var switchedNode: NavigationNode?
    public override var isWrapperNode: Bool { false }

    public override var childrenPublishers: [any Publisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$switchedNode.map { [$0].compactMap { $0 } }]
    }

    open override var view: AnyView {
        AnyView(SwitchedNavigationNodeView())
    }

}

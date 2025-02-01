import SwiftUI

public protocol SwitchedNavigationNode: NavigationNode {
    associatedtype ModifiedView: View
    var switchedNode: (any NavigationNode)? { get set }
    @ViewBuilder func body(for content: SwitchedNavigationNodeView<Self>) -> ModifiedView
}

public extension SwitchedNavigationNode {
    var children: [any NavigationNode] {
        baseNavigationNodeChildren + [switchedNode].compactMap { $0 }
    }

    var body: ModifiedView {
        body(for: SwitchedNavigationNodeView())
    }
}

import SwiftUI

public protocol TabsRootNavigationNode: NavigationNode {
    associatedtype ModifiedView: View
    var selectedTabNodeID: AnyHashable { get set }
    var tabsNodes: [TabNode] { get set }
    @ViewBuilder func body(for content: TabsRootNavigationNodeView<Self>) -> ModifiedView
}

public extension TabsRootNavigationNode {
    var children: [any NavigationNode] {
        baseNavigationNodeChildren + tabsNodes.map(\.navigationNode)
    }

    var body: ModifiedView {
        body(for: TabsRootNavigationNodeView())
    }
}

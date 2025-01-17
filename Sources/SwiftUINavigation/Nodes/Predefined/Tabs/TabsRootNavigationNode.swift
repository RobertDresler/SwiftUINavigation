import SwiftUI
import Combine

open class TabsRootNavigationNode: NavigationNode {

    @Published public internal(set) var selectedTabNode: TabNode
    @Published public internal(set) var tabsNodes: [TabNode]

    public override var childrenPublishers: [AnyPublisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$tabsNodes.map { $0.map { $0.navigationNode } }.eraseToAnyPublisher()]
    }

    public override var view: AnyView {
        AnyView(TabsRootNavigationNodeView())
    }

    public init(selectedTabNode: TabNode, tabsNodes: [TabNode]) {
        self.selectedTabNode = selectedTabNode
        self.tabsNodes = tabsNodes
    }

}

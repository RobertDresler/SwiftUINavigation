import SwiftUI
import Combine

public class TabsRootNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public internal(set) var selectedTabNode: TabNode
    @Published public internal(set) var tabsNodes: [TabNode]

    // MARK: Getters

    public override var childrenPublishers: [any Publisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$tabsNodes.map { $0.map { $0.navigationNode } }]
    }

    // MARK: Lifecycle

    public init(selectedTabNode: TabNode, tabsNodes: [TabNode]) {
        self.selectedTabNode = selectedTabNode
        self.tabsNodes = tabsNodes
        super.init()
    }

}

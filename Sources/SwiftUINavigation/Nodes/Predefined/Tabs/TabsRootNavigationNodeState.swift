import SwiftUI
import Combine

public class TabsRootNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public var selectedTabNode: TabNode
    @Published public var tabsNodes: [TabNode]

    // MARK: Getters

    public override var children: [any NavigationNode] {
        super.children + tabsNodes.map(\.navigationNode)
    }

    // MARK: Lifecycle

    public init(selectedTabNode: TabNode, tabsNodes: [TabNode]) {
        self.selectedTabNode = selectedTabNode
        self.tabsNodes = tabsNodes
        super.init()
    }

}

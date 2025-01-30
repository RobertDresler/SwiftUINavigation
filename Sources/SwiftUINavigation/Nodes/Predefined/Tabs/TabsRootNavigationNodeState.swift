import SwiftUI
import Combine

public class TabsRootNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public var selectedTabNodeID: AnyHashable
    @Published public var tabsNodes: [TabNode]

    // MARK: Getters

    public override var children: [any NavigationNode] {
        super.children + tabsNodes.map(\.navigationNode)
    }

    // MARK: Lifecycle

    public init(selectedTabNodeID: AnyHashable, tabsNodes: [TabNode]) {
        self.selectedTabNodeID = selectedTabNodeID
        self.tabsNodes = tabsNodes
        super.init()
    }

}

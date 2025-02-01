import SwiftUI
import Combine
import SwiftUINavigation

@NavigationNode
public final class SegmentedTabsNavigationNode {

    var tabs = [SegmentedTab]()
    var selectedTab: SegmentedTab

    public var children: [any NavigationNode] {
        baseNavigationNodeChildren + tabs.map(\.node)
    }

    public var body: some View {
        SegmentedTabsView()
    }

    public init(tabs: [SegmentedTab]) {
        guard let firstTab = tabs.first else {
            fatalError("SegmentedTabsNavigationNode requires at least one tab")
        }
        self.tabs = tabs
        self.selectedTab = firstTab
    }

}

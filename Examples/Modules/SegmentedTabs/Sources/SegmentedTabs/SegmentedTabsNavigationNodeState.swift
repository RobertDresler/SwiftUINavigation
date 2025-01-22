import SwiftUI
import Combine
import SwiftUINavigation

public class SegmentedTabsNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published var tabs = [SegmentedTab]()
    @Published var selectedTab: SegmentedTab

    // MARK: Getters

    public override var childrenPublishers: [any Publisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$tabs.map { $0.map { $0.node } }]
    }

    // MARK: Lifecycle

    public init(tabs: [SegmentedTab]) {
        guard let firstTab = tabs.first else {
            fatalError("SegmentedTabsNavigationNode requires at least one tab")
        }
        self.tabs = tabs
        self.selectedTab = firstTab
        super.init()
    }

}

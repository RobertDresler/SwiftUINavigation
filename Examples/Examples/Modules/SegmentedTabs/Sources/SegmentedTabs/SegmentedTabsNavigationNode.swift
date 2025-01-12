import SwiftUI
import Combine
import SwiftUINavigation

public final class SegmentedTabsNavigationNode: NavigationNode {

    @Published var tabs = [SegmentedTab]()
    @Published var selectedTab: SegmentedTab

    public override var childrenPublishers: [AnyPublisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$tabs.map { $0.map { $0.node } }.eraseToAnyPublisher()]
    }

    public override var view: AnyView {
        AnyView(SegmentedTabsView())
    }

    public init(tabs: [SegmentedTab]) {
        guard let firstTab = tabs.first else {
            fatalError("SegmentedTabsNavigationNode requires at least one tab")
        }
        self.tabs = tabs
        self.selectedTab = firstTab
        super.init()
    }

}

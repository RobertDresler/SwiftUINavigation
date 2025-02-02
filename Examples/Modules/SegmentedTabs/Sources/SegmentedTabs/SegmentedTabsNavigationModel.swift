import SwiftUI
import Combine
import SwiftUINavigation

@NavigationModel
public final class SegmentedTabsNavigationModel {

    var tabs = [SegmentedTab]()
    var selectedTab: SegmentedTab

    public var children: [any NavigationModel] {
        baseNavigationModelChildren + tabs.map(\.model)
    }

    public var body: some View {
        SegmentedTabsView()
    }

    public init(tabs: [SegmentedTab]) {
        guard let firstTab = tabs.first else {
            fatalError("SegmentedTabsNavigationModel requires at least one tab")
        }
        self.tabs = tabs
        self.selectedTab = firstTab
    }

}

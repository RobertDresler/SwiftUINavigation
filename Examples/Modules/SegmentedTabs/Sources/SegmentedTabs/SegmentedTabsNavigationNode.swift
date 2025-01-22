import SwiftUI
import Combine
import SwiftUINavigation

public final class SegmentedTabsNavigationNode: NavigationNode {

    public let state: SegmentedTabsNavigationNodeState

    public var body: some View {
        SegmentedTabsView()
    }

    public init(tabs: [SegmentedTab]) {
        state = SegmentedTabsNavigationNodeState(tabs: tabs)
    }

}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared

struct SegmentedTabsView: View {

    @EnvironmentNavigationNodeState private var navigationNodeState: SegmentedTabsNavigationNodeState

    var body: some View {
        VStack(spacing: 16) {
            picker
            selectedTabView
        }.padding()
    }

    private var picker: some View {
        Picker(
            "",
            selection: Binding(
                get: { navigationNodeState.selectedTab },
                set: { navigationNodeState.selectedTab = $0 }
            )
        ) {
            ForEach(navigationNodeState.tabs) { tab in
                Text(tab.name)
                    .tag(tab)
            }

        }.pickerStyle(.segmented)
    }

    private var selectedTabView: some View {
        NavigationNodeResolvedView(node: navigationNodeState.selectedTab.node)
    }

}

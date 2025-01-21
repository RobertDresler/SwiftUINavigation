import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared

struct SegmentedTabsView: View {

    @EnvironmentNavigationNode private var navigationNode: SegmentedTabsNavigationNode

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
                get: { navigationNode.selectedTab },
                set: { navigationNode.selectedTab = $0 }
            )
        ) {
            ForEach(navigationNode.tabs) { tab in
                Text(tab.name)
                    .tag(tab)
            }

        }.pickerStyle(.segmented)
    }

    private var selectedTabView: some View {
        NavigationNodeResolvedView(node: navigationNode.selectedTab.node)
    }

}

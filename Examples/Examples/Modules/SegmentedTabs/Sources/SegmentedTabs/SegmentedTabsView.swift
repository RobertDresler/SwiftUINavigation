import SwiftUI
import SwiftUINavigation
import Shared

struct SegmentedTabsView: View {

    @EnvironmentNavigationModel private var navigationModel: SegmentedTabsNavigationModel

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
                get: { navigationModel.selectedTab },
                set: { navigationModel.selectedTab = $0 }
            )
        ) {
            ForEach(navigationModel.tabs) { tab in
                Text(tab.name)
                    .tag(tab)
            }

        }.pickerStyle(.segmented)
    }

    private var selectedTabView: some View {
        NavigationModelResolvedView(model: navigationModel.selectedTab.model)
    }

}

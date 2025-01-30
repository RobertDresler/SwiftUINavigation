import SwiftUI

public struct TabsRootNavigationNodeView: View {

    @EnvironmentNavigationNodeState private var navigationNodeState: TabsRootNavigationNodeState

    public init() {}

    public var body: some View {
        TabView(selection: selection) {
            ForEach(navigationNodeState.tabsNodes, id: \.id) { node in
                node.resolvedView
            }
        }
    }

    private var selection: Binding<AnyHashable> {
        Binding(
            get: { navigationNodeState.selectedTabNodeID },
            set: { navigationNodeState.selectedTabNodeID = $0 }
        )
    }

}

import SwiftUI

public struct TabsRootNavigationNodeView: View {

    @EnvironmentNavigationNodeState private var navigationNodeState: TabsRootNavigationNodeState

    public init() {}

    public var body: some View {
        TabView(selection: selection) {
            ForEach(navigationNodeState.tabsNodes, id: \.navigationNode.id) { node in
                node.resolvedView
            }
        }
    }

    private var selection: Binding<String> {
        Binding(
            get: { navigationNodeState.selectedTabNode.navigationNode.id },
            set: { id in
                guard let selectedTabNode = navigationNodeState.tabsNodes.first(where: { $0.navigationNode.id == id }) else { return }
                navigationNodeState.selectedTabNode = selectedTabNode
            }
        )
    }

}

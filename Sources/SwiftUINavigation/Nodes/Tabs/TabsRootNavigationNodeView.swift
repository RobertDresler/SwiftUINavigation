import SwiftUI

struct TabsRootNavigationNodeView: View {

    @Namespace private var namespace
    @EnvironmentNavigationNode private var node: TabsRootNavigationNode

    // MARK: Getters

    var body: some View {
        TabView(selection: selection) {
            ForEach(node.tabsNodes, id: \.navigationNode.id) { node in
                node.resolvedView
            }
        }
    }

    private var selection: Binding<String> {
        Binding(
            get: { node.selectedTabNode.navigationNode.id },
            set: { id in
                guard let selectedTabNode = node.tabsNodes.first(where: { $0.navigationNode.id == id }) else { return }
                node.selectedTabNode = selectedTabNode
            }
        )
    }

}

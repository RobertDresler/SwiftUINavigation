import SwiftUI

public struct TabsRootNavigationNodeView<InputNavigationNode: TabsRootNavigationNode>: View {

    @EnvironmentNavigationNode private var navigationNode: InputNavigationNode

    public init() {}

    public var body: some View {
        TabView(selection: selection) {
            ForEach(navigationNode.tabsNodes, id: \.id) { node in
                node.resolvedView
            }
        }
    }

    private var selection: Binding<AnyHashable> {
        Binding(
            get: { navigationNode.selectedTabNodeID },
            set: { navigationNode.selectedTabNodeID = $0 }
        )
    }

}

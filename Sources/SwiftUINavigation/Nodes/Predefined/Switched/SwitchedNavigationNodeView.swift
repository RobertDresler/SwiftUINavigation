import SwiftUI

struct SwitchedNavigationNodeView: View {

    @EnvironmentNavigationNode private var node: SwitchedNavigationNode

    var body: some View {
        Group {
            if let switchedNode = node.switchedNode {
                NavigationNodeResolvedView(node: switchedNode)
                    .id(switchedNode.id)
            } else {
                Color.clear
            }
        }
    }

}

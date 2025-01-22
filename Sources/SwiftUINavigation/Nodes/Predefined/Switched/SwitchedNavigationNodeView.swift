import SwiftUI

public struct SwitchedNavigationNodeView: View {

    @EnvironmentNavigationNodeState private var navigationNodeState: SwitchedNavigationNodeState

    public init() {}

    public var body: some View {
        Group {
            if let switchedNode = navigationNodeState.switchedNode {
                NavigationNodeResolvedView(node: switchedNode)
                    .id(switchedNode.id)
            } else {
                Color.clear
            }
        }
    }

}

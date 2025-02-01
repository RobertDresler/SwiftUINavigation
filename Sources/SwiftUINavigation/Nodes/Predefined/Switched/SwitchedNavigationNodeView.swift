import SwiftUI

public struct SwitchedNavigationNodeView<InputNavigationNode: SwitchedNavigationNode>: View {

    @EnvironmentNavigationNode private var navigationNode: InputNavigationNode

    public init() {}

    public var body: some View {
        Group {
            if let switchedNode = navigationNode.switchedNode {
                NavigationNodeResolvedView(node: switchedNode)
                    .id(switchedNode.id)
            } else {
                Color.clear
            }
        }
    }

}

import SwiftUI

public struct SwitchedNavigationNodeView: View {

    @EnvironmentObject private var node: NavigationNode

    public init() {}

    public var body: some View {
        Group {
            if let switchedNode = node.switchedNode {
                NavigationNodeResolvedView(node: switchedNode)
            } else {
                Color.clear
            }
        }
    }

}

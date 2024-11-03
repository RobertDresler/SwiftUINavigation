import SwiftUI

public struct SwiftUINavigationSwitchedNodeResolvedView: View {

    @EnvironmentObject private var node: SwiftUINavigationNode

    public init() {}

    public var body: some View {
        Group { [weak node] in
            if let switchedNode = node?.switchedNode {
                SwiftUINavigationResolvedView(node: switchedNode)
            } else {
                Color.clear
            }
        }
    }

}

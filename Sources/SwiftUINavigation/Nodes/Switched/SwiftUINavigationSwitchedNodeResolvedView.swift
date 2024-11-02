import SwiftUI

public struct SwiftUINavigationSwitchedNodeResolvedView<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var node: SwiftUINavigationNode<Resolver.DeepLink>
    @EnvironmentObject private var resolver: Resolver

    public init() {}

    public var body: some View {
        Group { [weak node] in
            if let switchedNode = node?.switchedNode {
                SwiftUINavigationResolvedView<Resolver>(node: switchedNode)
            } else {
                Color.clear
            }
        }
    }

}

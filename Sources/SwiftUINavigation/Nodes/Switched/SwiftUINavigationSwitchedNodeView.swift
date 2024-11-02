import SwiftUI

public struct SwiftUINavigationSwitchedNodeView<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var resolver: Resolver
    @EnvironmentObject private var parentNode: SwiftUINavigationNode<Resolver.DeepLink>
    private var deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        SwiftUINavigationResolvedView<Resolver>(
            node: SwiftUINavigationNode(
                type: .switchedNode,
                value: .deepLink(deepLink),
                parent: parentNode
            )
        )
    }

}

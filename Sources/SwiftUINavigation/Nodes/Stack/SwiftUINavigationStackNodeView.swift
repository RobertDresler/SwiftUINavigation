import SwiftUI

public struct SwiftUINavigationStackNodeView<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var parentNode: SwiftUINavigationNode<Resolver.DeepLink>
    private var deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        SwiftUINavigationStackNodeResolvedView<Resolver>(
            node: SwiftUINavigationNode(
                type: .stackRoot,
                wrappedDeepLink: nil,
                parent: parentNode,
                stackNodes: [StackDeepLink(destination: deepLink)]
            )
        )
    }

}

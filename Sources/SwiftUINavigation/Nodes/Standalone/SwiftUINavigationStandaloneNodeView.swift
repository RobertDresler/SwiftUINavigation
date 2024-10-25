import SwiftUI

public struct SwiftUINavigationStandaloneNodeView<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var resolver: Resolver
    @EnvironmentObject private var parentNode: SwiftUINavigationNode<Resolver.DeepLink>
    private var deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        resolver.resolve(deepLink)
            .environmentObject(SwiftUINavigationNode(type: .standalone, wrappedDeepLink: deepLink, parent: parentNode))
    }

}

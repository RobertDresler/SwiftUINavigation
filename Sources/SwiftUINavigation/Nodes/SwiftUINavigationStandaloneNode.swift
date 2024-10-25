import SwiftUI

public struct SwiftUINavigationStandaloneNode<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var resolver: Resolver
    @EnvironmentObject private var parentNode: SwiftUINavigationGraphNode<Resolver.DeepLink>
    private var deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        resolver.resolve(deepLink)
            .environmentObject(SwiftUINavigationGraphNode(type: .standalone, wrappedDeepLink: deepLink, parent: parentNode))
    }

}

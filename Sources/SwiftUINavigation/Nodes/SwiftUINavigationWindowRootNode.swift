import SwiftUI

public struct SwiftUINavigationWindowRootNode<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var resolver: Resolver
    private var deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        resolver.resolve(deepLink)
            .environmentObject(SwiftUINavigationGraphNode(type: .root, wrappedDeepLink: deepLink, parent: nil))
    }

}

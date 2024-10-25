import SwiftUI

public struct SwiftUINavigationWindow<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    private let resolver: Resolver
    private let rootDeepLink: Resolver.DeepLink

    // MARK: Init

    public init(
        resolver: Resolver,
        rootDeepLink: Resolver.DeepLink
    ) {
        self.resolver = resolver
        self.rootDeepLink = rootDeepLink
    }

    public var body: some View {
        SwiftUINavigationWindowRootNode<Resolver>(deepLink: rootDeepLink)
            .environmentObject(resolver)
    }

}

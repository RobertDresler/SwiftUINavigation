import SwiftUI

public struct SwiftUINavigationWindow<
    Destination: NavigationDeepLink,
    Resolver: SwiftUINavigationDeepLinkResolver
>: View where Resolver.DeepLink == Destination {

    private let root: Destination
    private let resolver: Resolver

    // MARK: Init

    public init(
        root: Destination,
        resolver: Resolver
    ) {
        self.root = root
        self.resolver = resolver
    }

    public var body: some View {
        resolver.resolve(root)
            .environmentObject(resolver)
    }

}

import SwiftUI

public struct SwiftUINavigationWindow<
    Resolver: SwiftUINavigationDeepLinkResolver,
    SwitchedDeepLinkResolver: SwiftUINavigationSwitchedDeepLinkResolver<Resolver.DeepLink>
>: View {

    private let resolver: Resolver
    private let switchedDeepLinkResolver: SwitchedDeepLinkResolver
    private let rootNode = SwiftUINavigationGraphNode<Resolver.DeepLink>(wrappedDeepLink: nil, parent: nil)

    // MARK: Init

    public init(
        resolver: Resolver,
        switchedDeepLinkResolver: SwitchedDeepLinkResolver
    ) {
        self.resolver = resolver
        self.switchedDeepLinkResolver = switchedDeepLinkResolver
    }

    public var body: some View {
        SwiftUINavigationSwitchedNode<Resolver, SwitchedDeepLinkResolver>(
            switchedDeepLinkResolver: switchedDeepLinkResolver
        )
            .environmentObject(rootNode)
            .environmentObject(resolver)
    }

}

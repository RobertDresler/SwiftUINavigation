import SwiftUI

public struct SwiftUINavigationWindow<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @ObservedObject private var resolver: Resolver
    @ObservedObject private var rootNode: SwiftUINavigationNode<Resolver.DeepLink>

    // MARK: Init

    public init(
        resolver: Resolver,
        rootNode: SwiftUINavigationNode<Resolver.DeepLink>
    ) {
        self.resolver = resolver
        self.rootNode = rootNode
    }

    public var body: some View {
        SwiftUINavigationResolvedView<Resolver>(node: rootNode)
            .environmentObject(resolver)
    }

}

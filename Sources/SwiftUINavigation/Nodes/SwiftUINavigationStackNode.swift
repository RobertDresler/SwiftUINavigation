import SwiftUI

public struct SwiftUINavigationStackNode<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var parentNode: SwiftUINavigationGraphNode<Resolver.DeepLink>
    private var deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        SwiftUINavigationStack<Resolver>(
            node: SwiftUINavigationGraphNode(
                type: .stackRoot,
                wrappedDeepLink: nil,
                parent: parentNode,
                stackNodes: [StackDeepLink(destination: deepLink)]
            )
        )
    }

}

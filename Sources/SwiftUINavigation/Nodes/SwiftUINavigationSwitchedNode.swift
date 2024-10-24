import SwiftUI

public struct SwiftUINavigationSwitchedNode<
    Resolver: SwiftUINavigationDeepLinkResolver,
    SwitchedDeepLinkResolver: SwiftUINavigationSwitchedDeepLinkResolver<Resolver.DeepLink>
>: View {

    struct SwiftUINavigationSwitchedNodeInnerView: View {

        @EnvironmentObject private var resolver: Resolver
        @ObservedObject private var node: SwiftUINavigationGraphNode<Resolver.DeepLink>
        private let switchedDeepLinkResolver: SwitchedDeepLinkResolver

        init(parentNode: SwiftUINavigationGraphNode<Resolver.DeepLink>, switchedDeepLinkResolver: SwitchedDeepLinkResolver) {
            node = SwiftUINavigationGraphNode(wrappedDeepLink: nil, parent: parentNode)
            self.switchedDeepLinkResolver = switchedDeepLinkResolver
        }

        var body: some View {
            Group {
                if let deepLink = node.switchedNode?.wrappedDeepLink {
                    resolver.resolve(deepLink)
                } else {
                    EmptyView()
                }
            }
                .environmentObject(node)
                .onReceive(switchedDeepLinkResolver.switchedDeepLink) { switchedDeepLink in
                    guard let switchedDeepLink else { return }
                    node.executeCommand(.switchNode(switchedDeepLink))
                }
        }

    }

    @EnvironmentObject private var parentNode: SwiftUINavigationGraphNode<Resolver.DeepLink>
    private let switchedDeepLinkResolver: SwitchedDeepLinkResolver

    public init(switchedDeepLinkResolver: SwitchedDeepLinkResolver) {
        self.switchedDeepLinkResolver = switchedDeepLinkResolver
    }

    public var body: some View {
        SwiftUINavigationSwitchedNodeInnerView(parentNode: parentNode, switchedDeepLinkResolver: switchedDeepLinkResolver)
    }

}

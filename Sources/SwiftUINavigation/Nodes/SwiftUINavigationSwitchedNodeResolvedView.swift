import SwiftUI

public struct SwiftUINavigationSwitchedNodeResolvedView<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var node: SwiftUINavigationGraphNode<Resolver.DeepLink>
    @EnvironmentObject private var resolver: Resolver
    private let deepLink: Resolver.DeepLink

    public init(deepLink: Resolver.DeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        Group {
            if let deepLink = node.switchedNode?.wrappedDeepLink {
                resolver.resolve(deepLink)
            } else {
                Color.clear
            }
        }
            .onAppear { node.executeCommand(.switchNode(deepLink)) }
            .onChange(of: deepLink) { deepLink in node.executeCommand(.switchNode(deepLink)) }
    }

}

import SwiftUI

public struct FullScreenCoverPresentedNavigationNode: PresentedNavigationNode {

    public let node: any NavigationNode
    public let sourceID: String? = nil

    init(node: any NavigationNode) {
        self.node = node
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .fullScreenCover(
                isPresented: makeIsPresentedBinding(presentedNode: presentedNode, sourceID: sourceID),
                content: {
                    if let presentedNode = presentedNode as? Self {
                        NavigationNodeResolvedView(node: presentedNode.node)
                    }
                }
            )
    }

}

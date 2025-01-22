import SwiftUI

public struct FullScreenCoverPresentedNavigationNode: PresentedNavigationNode {

    // MARK: Getters

    public static func standalone(node: any NavigationNode) -> FullScreenCoverPresentedNavigationNode {
        FullScreenCoverPresentedNavigationNode(node: node)
    }

    public static func stacked(node: any NavigationNode) -> FullScreenCoverPresentedNavigationNode {
        FullScreenCoverPresentedNavigationNode(
            node: StackRootNavigationNode(
                stackNodes: [StackNavigationNode(destination: node, transition: nil)]
            )
        )
    }

    // MARK: Other

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

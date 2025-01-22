import SwiftUI

public struct SheetPresentedNavigationNode: PresentedNavigationNode {

    // MARK: Getters

    public static func standalone(node: any NavigationNode, sourceID: String? = nil) -> SheetPresentedNavigationNode {
        SheetPresentedNavigationNode(node: node, sourceID: sourceID)
    }

    public static func stacked(node: any NavigationNode, sourceID: String? = nil) -> SheetPresentedNavigationNode {
        SheetPresentedNavigationNode(
            node: StackRootNavigationNode(
                stackNodes: [StackNavigationNode(destination: node, transition: nil)]
            ),
            sourceID: sourceID
        )
    }

    // MARK: Other

    public let node: any NavigationNode
    public let sourceID: String?

    init(node: any NavigationNode, sourceID: String?) {
        self.node = node
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .sheet(
                isPresented: makeIsPresentedBinding(presentedNode: presentedNode, sourceID: sourceID),
                content: {
                    if let presentedNode = presentedNode as? Self {
                        NavigationNodeResolvedView(node: presentedNode.node)
                    }
                }
            )
    }

}

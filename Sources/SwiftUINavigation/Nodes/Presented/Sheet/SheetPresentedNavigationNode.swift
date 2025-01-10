import SwiftUI

public final class SheetPresentedNavigationNode: PresentedNavigationNode {

    // MARK: Getters

    public static func standalone(node: NavigationNode) -> SheetPresentedNavigationNode {
        SheetPresentedNavigationNode(node: node)
    }

    public static func stacked(node: NavigationNode) -> SheetPresentedNavigationNode {
        SheetPresentedNavigationNode(
            node: StackRootNavigationNode(
                stackNodes: [StackNavigationNode(destination: node, transition: nil)]
            )
        )
    }

    // MARK: Other

    public let node: NavigationNode
    public let sourceID: String? = nil

    init(node: NavigationNode) {
        self.node = node
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

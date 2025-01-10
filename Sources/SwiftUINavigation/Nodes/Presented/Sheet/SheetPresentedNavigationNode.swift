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

    init(node: NavigationNode) {
        self.node = node
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        id: String?
    ) -> some View {
        content
            .sheet(
                isPresented: makeIsPresentedBinding(presentedNode: presentedNode),
                content: {
                    if let presentedNode = presentedNode as? Self {
                        NavigationNodeResolvedView(node: presentedNode.node)
                    }
                }
            )
    }

}

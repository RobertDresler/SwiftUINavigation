import SwiftUI

public struct PresentedNavigationNode {

    public enum Style: Hashable {
        case fullScreenCover
        case sheet(detents: Set<PresentationDetent>)
    }

    public let style: Style
    public let node: NavigationNode

}

// MARK: Factory Methods

public extension PresentedNavigationNode {
    static func standalone(style: Style, node: NavigationNode) -> PresentedNavigationNode {
        PresentedNavigationNode(style: style, node: node)
    }

    static func stacked(style: Style, node: NavigationNode) -> PresentedNavigationNode {
        PresentedNavigationNode(
            style: style,
            node: StackRootNavigationNode(
                stackNodes: [NavigationNodeWithStackTransition(destination: node, transition: nil)]
            )
        )
    }
}

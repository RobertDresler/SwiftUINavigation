import SwiftUI

@MainActor
public protocol PresentedNavigationNode {
    associatedtype Body: View
    var node: any NavigationNode { get }
    var sourceID: String? { get }
    static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        sourceID: String?
    ) -> Body
}

public extension PresentedNavigationNode {
    static func makeIsPresentedBinding(
        presentedNode: (any PresentedNavigationNode)?,
        sourceID: String?
    ) -> Binding<Bool> {
        Binding(
            get: {
                if let presentedNode = presentedNode as? Self,
                presentedNode.sourceID == sourceID {
                    true
                } else {
                    false
                }
            },
            set: { isPresented in
                guard !isPresented else { return }
                presentedNode?.node.parent?.state.presentedNode = nil
            }
        )
    }
}

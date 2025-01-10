import SwiftUI

@MainActor
public protocol PresentedNavigationNode: AnyObject {
    associatedtype Body: View
    var node: NavigationNode { get }
    static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        id: String?
    ) -> Body
}

public extension PresentedNavigationNode {
    static func makeIsPresentedBinding<AdditionalCheckNavigationNode: NavigationNode>(
        presentedNode: (any PresentedNavigationNode)?,
        additionalCheck: @escaping (AdditionalCheckNavigationNode) -> Bool = { _ in true }
    ) -> Binding<Bool> {
        Binding(
            get: {
                if let presentedNode = presentedNode as? Self,
                let additionalCheckNavigationNode = presentedNode.node as? AdditionalCheckNavigationNode,
                additionalCheck(additionalCheckNavigationNode) {
                    true
                } else {
                    false
                }
            },
            set: { isPresented in
                guard !isPresented else { return }
                presentedNode?.node.parent?.presentedNode = nil
            }
        )
    }

    static func makeIsPresentedBinding(presentedNode: (any PresentedNavigationNode)?) -> Binding<Bool> {
        Binding(
            get: {
                presentedNode is Self
            },
            set: { isPresented in
                guard !isPresented else { return }
                presentedNode?.node.parent?.presentedNode = nil
            }
        )
    }
}

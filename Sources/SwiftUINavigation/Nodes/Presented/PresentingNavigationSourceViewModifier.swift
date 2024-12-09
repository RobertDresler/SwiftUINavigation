import SwiftUI

public struct PresentingNavigationSourceViewModifier: ViewModifier {

    @EnvironmentNavigationNode private var navigationNode
    @Environment(\.registeredCustomPresentableNavigationNodes) private var registeredCustomPresentableNavigationNodes

    private let id: String?

    init(id: String?) {
        self.id = id
    }

    public func body(content: Content) -> some View {
        modifyNodeViewWithPresentableNavigationNodes(content)
    }

    func modifyNodeViewWithPresentableNavigationNodes(_ view: some View) -> some View {
        registeredPresentableNavigationNodes.reduce(AnyView(view)) { resolvedView, modifier in
            AnyView(
                modifier.presenterResolvedViewModifier(
                    presentedNode: navigationNode.presentedNode,
                    content: resolvedView,
                    id: id
                )
            )
        }
    }

    private var registeredPresentableNavigationNodes: [any PresentedNavigationNode.Type] {
        [
            FullScreenCoverPresentedNavigationNode.self,
            AlertPresentedNavigationNode.self,
            ConfirmationDialogPresentedNavigationNode.self
        ]
        + registeredCustomPresentableNavigationNodes
    }

}

extension View {
    func presentingNavigationSource(id: String?) -> some View {
        modifier(PresentingNavigationSourceViewModifier(id: id))
    }

    public func presentingNavigationSource(id: String) -> some View {
        presentingNavigationSource(id: id as? String)
    }
}

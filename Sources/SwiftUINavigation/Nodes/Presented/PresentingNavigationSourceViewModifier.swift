import SwiftUI

public struct PresentingNavigationSourceViewModifier: ViewModifier {

    @EnvironmentObject private var navigationNode: AnyNavigationNode
    @Environment(\.registeredCustomPresentableNavigationNodes) private var registeredCustomPresentableNavigationNodes

    private let sourceID: String?

    init(sourceID: String?) {
        self.sourceID = sourceID
    }

    public func body(content: Content) -> some View {
        modifyNodeViewWithPresentableNavigationNodes(content)
    }

    func modifyNodeViewWithPresentableNavigationNodes(_ view: some View) -> some View {
        registeredPresentableNavigationNodes.reduce(AnyView(view)) { resolvedView, modifier in
            AnyView(
                modifier.presenterResolvedViewModifier(
                    presentedNode: navigationNode.state.presentedNode,
                    content: resolvedView,
                    sourceID: sourceID
                )
            )
        }
    }

    private var registeredPresentableNavigationNodes: [any PresentedNavigationNode.Type] {
        [
            FullScreenCoverPresentedNavigationNode.self,
            SheetPresentedNavigationNode.self,
            AlertPresentedNavigationNode.self,
            ConfirmationDialogPresentedNavigationNode.self
        ]
        + registeredCustomPresentableNavigationNodes
    }

}

extension View {
    func presentingNavigationSource(id: String?) -> some View {
        modifier(PresentingNavigationSourceViewModifier(sourceID: id))
    }

    public func presentingNavigationSource(id: String) -> some View {
        presentingNavigationSource(id: id as? String)
    }
}

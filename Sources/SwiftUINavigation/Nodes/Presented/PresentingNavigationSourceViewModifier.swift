import SwiftUI

public struct PresentingNavigationSourceViewModifier: ViewModifier {

    @EnvironmentObject private var navigationModel: AnyNavigationModel
    @Environment(\.registeredCustomPresentableNavigationModels) private var registeredCustomPresentableNavigationModels

    private let sourceID: String?

    init(sourceID: String?) {
        self.sourceID = sourceID
    }

    public func body(content: Content) -> some View {
        modifyModelViewWithPresentableNavigationModels(content)
    }

    func modifyModelViewWithPresentableNavigationModels(_ view: some View) -> some View {
        registeredPresentableNavigationModels.reduce(AnyView(view)) { resolvedView, modifier in
            AnyView(
                modifier.presenterResolvedViewModifier(
                    presentedModel: navigationModel.presentedModel,
                    content: resolvedView,
                    sourceID: sourceID
                )
            )
        }
    }

    private var registeredPresentableNavigationModels: [any PresentedNavigationModel.Type] {
        [
            FullScreenCoverPresentedNavigationModel.self,
            SheetPresentedNavigationModel.self,
            AlertPresentedNavigationModel.self,
            ConfirmationDialogPresentedNavigationModel.self
        ]
        + registeredCustomPresentableNavigationModels
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

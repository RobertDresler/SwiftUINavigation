import SwiftUI

#if os(iOS)
public struct FullScreenCoverPresentedNavigationModel: PresentedNavigationModel {

    public let model: any NavigationModel
    public let sourceID: String? = nil

    init(model: any NavigationModel) {
        self.model = model
    }

    public static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .fullScreenCover(
                isPresented: makeIsPresentedBinding(presentedModel: presentedModel, sourceID: sourceID),
                content: {
                    if let presentedModel = presentedModel as? Self {
                        NavigationModelResolvedView(model: presentedModel.model)
                    }
                }
            )
    }

}
#endif

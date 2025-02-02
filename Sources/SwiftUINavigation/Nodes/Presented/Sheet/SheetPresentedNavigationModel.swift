import SwiftUI

public struct SheetPresentedNavigationModel: PresentedNavigationModel {

    public let model: any NavigationModel
    public let sourceID: String?

    init(model: any NavigationModel, sourceID: String?) {
        self.model = model
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .sheet(
                isPresented: makeIsPresentedBinding(presentedModel: presentedModel, sourceID: sourceID),
                content: {
                    if let presentedModel = presentedModel as? Self {
                        NavigationModelResolvedView(model: presentedModel.model)
                    }
                }
            )
    }

}

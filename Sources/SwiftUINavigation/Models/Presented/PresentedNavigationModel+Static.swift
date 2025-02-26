import SwiftUI

#if os(iOS)
public extension PresentedNavigationModel where Self == FullScreenCoverPresentedNavigationModel {
    static func fullScreenCover(
        _ model: any NavigationModel,
        transition: AnyTransition? = nil
    ) -> FullScreenCoverPresentedNavigationModel {
        FullScreenCoverPresentedNavigationModel(model: model, transition: transition)
    }
}
#endif

public extension PresentedNavigationModel where Self == SheetPresentedNavigationModel {
    static func sheet(_ model: any NavigationModel, sourceID: String? = nil) -> SheetPresentedNavigationModel {
        SheetPresentedNavigationModel(model: model, sourceID: sourceID)
    }
}

public extension PresentedNavigationModel where Self == AlertPresentedNavigationModel {
    static func alert(_ inputData: AlertInputData, sourceID: String? = nil) -> AlertPresentedNavigationModel {
        AlertPresentedNavigationModel(inputData: inputData, sourceID: sourceID)
    }
}

public extension PresentedNavigationModel where Self == ConfirmationDialogPresentedNavigationModel {
    static func confirmationDialog(
        _ inputData: ConfirmationDialogInputData,
        sourceID: String? = nil
    ) -> ConfirmationDialogPresentedNavigationModel {
        ConfirmationDialogPresentedNavigationModel(inputData: inputData, sourceID: sourceID)
    }
}

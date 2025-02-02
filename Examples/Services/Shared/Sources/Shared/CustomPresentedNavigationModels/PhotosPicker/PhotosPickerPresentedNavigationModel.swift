import SwiftUI
import PhotosUI
import SwiftUINavigation

public struct PhotosPickerPresentedNavigationModel: PresentedNavigationModel {

    // MARK: Other

    public let model: any NavigationModel
    public let sourceID: String?

    public init(inputData: PhotosPickerInputData, sourceID: String? = nil) {
        self.model = PhotosPickerNavigationModel(inputData: inputData)
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .photosPicker(
                isPresented: makeIsPresentedBinding(presentedModel: presentedModel, sourceID: sourceID),
                selection: Binding(
                    get: { (presentedModel?.model as? PhotosPickerNavigationModel)?.inputData.photosPickerItem ?? [] },
                    set: { _ in } // TODO: -RD- implement
                ),
                maxSelectionCount: 3
            )
    }

}

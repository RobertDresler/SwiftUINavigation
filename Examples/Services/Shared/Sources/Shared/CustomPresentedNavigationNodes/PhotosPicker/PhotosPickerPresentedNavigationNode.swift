import SwiftUI
import PhotosUI
import SwiftUINavigation

public struct PhotosPickerPresentedNavigationNode: PresentedNavigationNode {

    // MARK: Other

    public let node: any NavigationNode
    public let sourceID: String?

    public init(inputData: PhotosPickerInputData, sourceID: String? = nil) {
        self.node = PhotosPickerNavigationNode(inputData: inputData)
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .photosPicker(
                isPresented: makeIsPresentedBinding(presentedNode: presentedNode, sourceID: sourceID),
                selection: Binding(
                    get: { (presentedNode?.node as? PhotosPickerNavigationNode)?.inputData.photosPickerItem ?? [] },
                    set: { _ in } // TODO: -RD- implement
                ),
                maxSelectionCount: 3
            )
    }

}

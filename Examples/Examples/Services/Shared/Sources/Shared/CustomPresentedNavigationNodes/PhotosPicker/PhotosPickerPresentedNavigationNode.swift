import SwiftUI
import PhotosUI
import SwiftUINavigation

public final class PhotosPickerPresentedNavigationNode: PresentedNavigationNode {

    // MARK: Other

    public let node: NavigationNode

    public init(inputData: PhotosPickerInputData, sourceID: String? = nil) {
        self.node = PhotosPickerNavigationNode(inputData: inputData, sourceID: sourceID)
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        id: String?
    ) -> some View {
        content
            .photosPicker(
                isPresented: makeIsPresentedBinding(
                    presentedNode: presentedNode,
                    additionalCheck: { (node: PhotosPickerNavigationNode) in node.sourceID == id }
                ),
                selection: Binding(
                    get: { (presentedNode?.node as? PhotosPickerNavigationNode)?.inputData.photosPickerItem ?? [] },
                    set: { _ in } // TODO: -RD- implement
                ),
                maxSelectionCount: 3
            )
    }

}

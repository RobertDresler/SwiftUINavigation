import SwiftUINavigation

public final class PhotosPickerNavigationNode: NavigationNode {

    let inputData: PhotosPickerInputData
    let sourceID: String?

    init(inputData: PhotosPickerInputData, sourceID: String?) {
        self.inputData = inputData
        self.sourceID = sourceID
    }

}


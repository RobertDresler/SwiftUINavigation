import SwiftUINavigation
import SwiftUI

@NavigationModel
final class PhotosPickerNavigationModel {

    var body: EmptyView {
        EmptyView()
    }
    
    let inputData: PhotosPickerInputData

    init(inputData: PhotosPickerInputData) {
        self.inputData = inputData
    }

}


import SwiftUINavigation
import SwiftUI

@NavigationNode
final class PhotosPickerNavigationNode {

    var body: EmptyView {
        EmptyView()
    }
    
    let inputData: PhotosPickerInputData

    init(inputData: PhotosPickerInputData) {
        self.inputData = inputData
    }

}


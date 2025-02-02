import PhotosUI
import SwiftUI

public struct PhotosPickerInputData {

    let maxSelectionCount: Int
    let photosPickerItem: [PhotosPickerItem]

    public init(maxSelectionCount: Int, photosPickerItem: [PhotosPickerItem]) {
        self.maxSelectionCount = maxSelectionCount
        self.photosPickerItem = photosPickerItem
    }
    
}

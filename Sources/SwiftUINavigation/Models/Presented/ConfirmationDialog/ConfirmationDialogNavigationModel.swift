import SwiftUI

@NavigationModel
final class ConfirmationDialogNavigationModel {

    var body: EmptyView {
        EmptyView()
    }

    let inputData: ConfirmationDialogInputData

    init(inputData: ConfirmationDialogInputData) {
        self.inputData = inputData
    }

}

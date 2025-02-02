import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@MainActor final class CustomConfirmationDialogModel: ObservableObject {

    let inputData: CustomConfirmationDialogInputData
    private unowned let navigationModel: CustomConfirmationDialogNavigationModel

    init(inputData: CustomConfirmationDialogInputData, navigationModel: CustomConfirmationDialogNavigationModel) {
        self.inputData = inputData
        self.navigationModel = navigationModel
    }

    func confirm() {
        navigationModel.sendMessage(CustomConfirmationDialogConfirmationNavigationMessage())
        navigationModel.dismiss()
    }

}


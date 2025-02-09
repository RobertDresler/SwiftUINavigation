import SwiftUINavigation
import SwiftUI
import Shared

@MainActor final class CustomConfirmationDialogViewModel: ObservableObject {

    let inputData: CustomConfirmationDialogInputData
    private unowned let navigationModel: CustomConfirmationDialogNavigationModel

    init(inputData: CustomConfirmationDialogInputData, navigationModel: CustomConfirmationDialogNavigationModel) {
        self.inputData = inputData
        self.navigationModel = navigationModel
    }

    func confirm() {
        navigationModel.confirm()
    }

}


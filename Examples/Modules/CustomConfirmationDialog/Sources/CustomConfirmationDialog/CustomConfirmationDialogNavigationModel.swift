import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class CustomConfirmationDialogNavigationModel {

    private let inputData: CustomConfirmationDialogInputData

    public init(inputData: CustomConfirmationDialogInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        CustomConfirmationDialogView(inputData: inputData)
    }

    func sendConfirmationMessage() {
        sendMessage(CustomConfirmationDialogConfirmationNavigationMessage())
    }

    func dismiss() {
        execute(.dismiss())
    }

}

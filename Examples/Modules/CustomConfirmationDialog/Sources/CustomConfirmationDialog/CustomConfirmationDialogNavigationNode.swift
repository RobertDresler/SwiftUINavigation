import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationNode
public final class CustomConfirmationDialogNavigationNode {

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
        executeCommand(DismissNavigationCommand())
    }

}

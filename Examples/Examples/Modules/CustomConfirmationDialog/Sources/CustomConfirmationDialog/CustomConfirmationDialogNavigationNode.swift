import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class CustomConfirmationDialogNavigationNode: NavigationNode {

    private let inputData: CustomConfirmationDialogInputData

    public init(inputData: CustomConfirmationDialogInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(CustomConfirmationDialogView(inputData: inputData))
    }

    func sendConfirmationMessage() {
        sendMessage(CustomConfirmationDialogConfirmationNavigationMessage())
    }

    func dismiss() {
        executeCommand(DismissNavigationCommand())
    }

}

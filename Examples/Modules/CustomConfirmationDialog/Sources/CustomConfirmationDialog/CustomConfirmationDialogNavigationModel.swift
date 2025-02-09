import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class CustomConfirmationDialogNavigationModel {

    lazy var viewModel = CustomConfirmationDialogViewModel(
        inputData: inputData,
        navigationModel: self
    )

    private let inputData: CustomConfirmationDialogInputData

    public init(inputData: CustomConfirmationDialogInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        CustomConfirmationDialogView(viewModel: viewModel)
    }

    func confirm() {
        sendMessage(CustomConfirmationDialogConfirmationNavigationMessage())
        dismiss()
    }

    func dismiss() {
        execute(.dismiss())
    }

}

import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class CustomConfirmationDialogNavigationModel {

    lazy var model = CustomConfirmationDialogModel(
        inputData: inputData,
        navigationModel: self
    )

    private let inputData: CustomConfirmationDialogInputData

    public init(inputData: CustomConfirmationDialogInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        CustomConfirmationDialogView(model: model)
    }

    func dismiss() {
        execute(.dismiss())
    }

}

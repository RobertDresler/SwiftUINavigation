import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Shared

struct CustomConfirmationDialogView: View {

    @EnvironmentNavigationModel private var navigationModel: CustomConfirmationDialogNavigationModel
    @ObservedObject var model: CustomConfirmationDialogModel

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 24) {
                title
                message
            }
            Spacer()
            confirmButton
        }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton
                }
            }
            .presentationDetents([.medium])
    }

    private var dismissButton: some View {
        DismissButton(action: { dismiss() })
    }

    private var title: some View {
        Text(model.inputData.title)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }

    private var message: some View {
        Text(model.inputData.message)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
    }

    private var confirmButton: some View {
        PrimaryButton(
            title: model.inputData.confirmButtonTitle,
            action: { model.confirm() }
        )
    }

    // MARK: Actions

    private func dismiss() {
        navigationModel.dismiss()
    }

}

#Preview {
    CustomConfirmationDialogNavigationModel(
        inputData: CustomConfirmationDialogInputData(
            title: "Confirm Logout",
            message: "Are you sure you want to log out? You can easily log in again anytime.",
            confirmButtonTitle: "Log Out"
        )
    ).body
}

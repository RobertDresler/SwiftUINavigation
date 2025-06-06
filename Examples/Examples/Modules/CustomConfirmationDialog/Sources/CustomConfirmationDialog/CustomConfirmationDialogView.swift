import SwiftUI
import SwiftUINavigation
import Shared

struct CustomConfirmationDialogView: View {

    @EnvironmentNavigationModel private var navigationModel: CustomConfirmationDialogNavigationModel
    @ObservedObject var viewModel: CustomConfirmationDialogViewModel

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
            #if os(iOS)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    dismissButton
                }
            }
            #endif
            .presentationDetents([.medium])
    }

    private var dismissButton: some View {
        DismissButton(action: { dismiss() })
    }

    private var title: some View {
        Text(viewModel.inputData.title)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }

    private var message: some View {
        Text(viewModel.inputData.message)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
    }

    private var confirmButton: some View {
        PrimaryButton(
            title: viewModel.inputData.confirmButtonTitle,
            action: { viewModel.confirm() }
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

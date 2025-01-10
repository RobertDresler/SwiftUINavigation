import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Shared

struct CustomConfirmationDialogView: View {

    @EnvironmentNavigationNode private var navigationNode: CustomConfirmationDialogNavigationNode

    var inputData: CustomConfirmationDialogInputData

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
        Text(inputData.title)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
    }

    private var message: some View {
        Text(inputData.message)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
    }

    private var confirmButton: some View {
        Button(action: { sendConfirmationMessage() }) {
            Text(inputData.confirmButtonTitle)
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

    // MARK: Actions

    private func sendConfirmationMessage() {
        navigationNode.sendConfirmationMessage()
        dismiss()
    }

    private func dismiss() {
        navigationNode.executeCommand(DismissNavigationCommand())
    }

}

#Preview {
    CustomConfirmationDialogNavigationNode(
        inputData: CustomConfirmationDialogInputData(
            title: "Confirm Logout",
            message: "Are you sure you want to log out? You can easily log in again anytime.",
            confirmButtonTitle: "Log Out"
        )
    ).view
}

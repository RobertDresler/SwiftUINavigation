import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

struct SettingsView: View {

    @EnvironmentNavigationNode private var navigationNode: SettingsNavigationNode
    @EnvironmentObject private var userRepository: UserRepository
    var inputData: SettingsInputData

    var body: some View {
        VStack {
            Text("This is settings")
            logoutButton
        }
    }

    private var logoutButton: some View {
        Button("Logout", action: { confirmLogout() })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
            .presentingNavigationSource(id: logoutButtonConfirmationDialogSourceID)
    }

    private var logoutButtonConfirmationDialogSourceID: String {
        "logoutButton"
    }

    // MARK: Actions

    func confirmLogout() {
        navigationNode.executeCommand(
            PresentOnGivenNodeNavigationCommand(
                presentedNode: ConfirmationDialogPresentedNavigationNode(
                    inputData: ConfirmationDialogInputData(
                        message: "Do you really want to logout?",
                        actions: [
                            ConfirmationDialogInputData.Action(
                                title: "Cancel",
                                role: .cancel
                            ),
                            ConfirmationDialogInputData.Action(
                                title: "Logout",
                                role: .destructive,
                                handler: { logout() }
                            )
                        ]
                    ),
                    sourceID: logoutButtonConfirmationDialogSourceID
                )
            )
        )
    }

    func logout() {
        userRepository.isUserLogged = false
    }

}

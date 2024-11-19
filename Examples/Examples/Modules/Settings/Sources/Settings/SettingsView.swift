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
        Button("Logout", action: { logout() })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    }

    // MARK: Actions

    func logout() {
        userRepository.isUserLogged = false
    }

}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

struct StartView: View {

    @EnvironmentNavigationNode private var navigationNode: StartNavigationNode
    @EnvironmentObject private var userRepository: UserRepository

    var inputData: StartInputData

    var body: some View {
        VStack(spacing: 48) {
            title
            VStack(spacing: 24) {
                prompt
                loginButton
            }
        }.padding()
    }

    private var title: some View {
        Text("Welcome to Symbols!")
            .font(.system(size: 40, weight: .medium))
            .multilineTextAlignment(.center)
    }

    private var prompt: some View {
        Text("Start by logging in")
            .font(.system(size: 24))
            .multilineTextAlignment(.center)
    }

    private var loginButton: some View {
        Button("Login", action: { login() })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
    }

    // MARK: Actions

    private func login() {
        userRepository.isUserLogged = true
    }

}

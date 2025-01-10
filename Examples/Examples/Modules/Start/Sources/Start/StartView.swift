import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

struct StartView: View {

    @EnvironmentNavigationNode private var navigationNode: StartNavigationNode
    @EnvironmentObject private var userRepository: UserRepository

    var inputData: StartInputData

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 24) {
                title
                welcomeText
            }
            Spacer()
            VStack(spacing: 8) {
                createAccountButton
                loginButton
            }
        }.padding()
    }

    private var title: some View {
        Text("Welcome to Examples!")
            .font(.system(size: 40, weight: .medium))
            .multilineTextAlignment(.center)
    }

    private var welcomeText: some View {
        Text("👋")
            .font(.system(size: 100))
    }

    private var createAccountButton: some View {
        Button(action: { createAccount() }) {
            Text("Create Account (Onboarding)")
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

    private var loginButton: some View {
        Button(action: { login() }) {
            Text("Already have an account (Login)")
                .multilineTextAlignment(.center)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
        }
    }

    // MARK: Actions

    private func createAccount() {
        // TODO: -RD- implement
    }

    private func login() {
        userRepository.isUserLogged = true
    }

}

#Preview {
    StartNavigationNode(inputData: StartInputData())
        .view
        .environmentObject(UserRepository())
}

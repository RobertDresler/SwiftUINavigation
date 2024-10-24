import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

struct StartView: View {

    @EnvironmentObject private var userRepository: UserRepository

    var inputData: StartInputData
    var executeNavigationCommand: (SwiftUINavigationGraphNode<ExamplesNavigationDeepLink>.Command) -> Void

    var body: some View {
        VStack {
            Text("User not logged")
            Button("Login", action: { login() })
        }
    }

    // MARK: Actions

    private func login() {
        userRepository.isUserLogged = true
    }

}

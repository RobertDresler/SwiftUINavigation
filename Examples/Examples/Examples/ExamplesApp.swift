import SwiftUI
import SwiftData
import SwiftUINavigation
import ExamplesNavigation
import ExamplesNavigationDeepLinkHandler
import UserRepository
import App

@main
struct ExamplesApp: App {

    private let userRepository = UserRepository()

    var body: some Scene {
        WindowGroup {
            NavigationWindow(
                rootNode: AppNavigationNode(
                    userRepository: userRepository,
                    defaultDeepLinkHandler: ExamplesNavigationDeepLinkHandler()
                )
            ).environmentObject(userRepository)
        }
    }

}
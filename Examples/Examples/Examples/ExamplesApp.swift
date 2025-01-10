import SwiftUI
import SwiftData
import SwiftUINavigation
import ExamplesNavigation
import ExamplesNavigationDeepLinkHandler
import UserRepository
import App
import Shared

@main
struct ExamplesApp: App {

    private let userRepository = UserRepository()

    init() {
        NavigationConfig.shared.isDebugPrintEnabled = true
    }

    var body: some Scene {
        WindowGroup {
            NavigationWindow(
                rootNode: AppNavigationNode(
                    userRepository: userRepository,
                    defaultDeepLinkHandler: ExamplesNavigationDeepLinkHandler()
                )
            )
                .registerCustomPresentableNavigationNodes([PhotosPickerPresentedNavigationNode.self])
                .environmentObject(userRepository)
        }
    }

}

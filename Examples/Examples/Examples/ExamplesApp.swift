import SwiftUI
import SwiftData
import SwiftUINavigation
import ExamplesNavigation
import ExamplesNavigationDeepLinkHandler
import UserRepository
import App
import Shared
import NotificationsService
import DeepLinkForwarderService
import OnboardingService
import OnboardingNavigation

@main
struct ExamplesApp: App {

    // MARK: Dependencies

    final class Dependencies {

        let userRepository = UserRepository()
        let notificationCenter = UNUserNotificationCenter.current()
        lazy var notificationsService = NotificationsService(notificationCenter: notificationCenter)
        let deepLinkForwarderService = DeepLinkForwarderService()
        lazy var onboardingService = OnboardingService(
            onboardingNavigationCommandFactory: DefaultOnboardingNavigationCommandFactory(),
            userRepository: userRepository
        )

    }

    private let dependencies: Dependencies

    // MARK: Body

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    init() {
        dependencies = Dependencies()
        delegate.configure(
            notificationCenter: dependencies.notificationCenter,
            deepLinkForwarderService: dependencies.deepLinkForwarderService
        )
        NavigationConfig.shared.isDebugPrintEnabled = true
    }

    var body: some Scene {
        WindowGroup {
            NavigationWindow(
                rootNode: AppNavigationNode(
                    userRepository: dependencies.userRepository,
                    deepLinkForwarderService: dependencies.deepLinkForwarderService,
                    onboardingService: dependencies.onboardingService
                ),
                defaultDeepLinkHandler: ExamplesNavigationDeepLinkHandler(
                    userRepository: dependencies.userRepository
                )
            )
                .registerCustomPresentableNavigationNodes([PhotosPickerPresentedNavigationNode.self])
                .environmentObject(dependencies.userRepository)
                .environmentObject(dependencies.notificationsService)
                .environmentObject(dependencies.deepLinkForwarderService)
                .environmentObject(dependencies.onboardingService)
        }
    }

}

import SwiftUI
import SwiftData
import SwiftUINavigation
import ExamplesNavigation
import ExamplesNavigationDeepLinkHandler
import FlagsRepository
import App
import Shared
import NotificationsService
import DeepLinkForwarderService
import OnboardingService
import OnboardingNavigation
import Waiting

@main
struct ExamplesApp: App {

    // MARK: Dependencies

    @MainActor
    final class Dependencies {
        let flagsRepository = FlagsRepository()
        let notificationCenter = UNUserNotificationCenter.current()
        lazy var notificationsService = NotificationsService(notificationCenter: notificationCenter)
        let deepLinkForwarderService = DeepLinkForwarderService()
        lazy var onboardingService = OnboardingService(
            onboardingNavigationCommandFactory: DefaultOnboardingNavigationCommandFactory(),
            flagsRepository: flagsRepository
        )
        lazy var defaultDeepLinkHandler = ExamplesNavigationDeepLinkHandler(flagsRepository: flagsRepository)
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
                    flagsRepository: dependencies.flagsRepository,
                    deepLinkForwarderService: dependencies.deepLinkForwarderService,
                    onboardingService: dependencies.onboardingService
                ),
                defaultDeepLinkHandler: dependencies.defaultDeepLinkHandler
            )
                .registerCustomPresentableNavigationNodes([PhotosPickerPresentedNavigationNode.self])
                .environmentObject(dependencies.flagsRepository)
                .environmentObject(dependencies.notificationsService)
                .environmentObject(dependencies.deepLinkForwarderService)
                .environmentObject(dependencies.onboardingService)
        }
        WindowGroup(id: WindowID.waiting.rawValue) {
            NavigationWindow(
                rootNode: WaitingNavigationNode(
                    inputData: WaitingInputData(),
                    flagsRepository: dependencies.flagsRepository
                ),
                defaultDeepLinkHandler: dependencies.defaultDeepLinkHandler
            )
        }
    }

}

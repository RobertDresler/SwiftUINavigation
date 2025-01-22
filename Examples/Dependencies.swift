import FlagsRepository
import UserNotifications
import NotificationsService
import DeepLinkForwarderService
import OnboardingService
import OnboardingNavigation
import ExamplesNavigationDeepLinkHandler

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

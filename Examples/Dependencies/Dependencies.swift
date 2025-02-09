import UserNotifications
import Shared

@MainActor
final class Dependencies {
    let flagsRepository = FlagsRepository()
    let notificationCenter = UNUserNotificationCenter.current()
    lazy var notificationsService = NotificationsService(notificationCenter: notificationCenter)
    let deepLinkForwarderService = DeepLinkForwarderService()
    lazy var onboardingService = OnboardingService(
        moveInOnboardingNavigationCommandFactory: DefaultMoveInOnboardingNavigationCommandFactory(),
        flagsRepository: flagsRepository
    )
    lazy var handleDeepLinkNavigationCommandFactory = DefaultHandleDeepLinkNavigationCommandFactory(flagsRepository: flagsRepository)
}

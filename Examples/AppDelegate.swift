import SwiftUI
import DeepLinkForwarderService

final class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func configure(
        notificationCenter: UNUserNotificationCenter,
        deepLinkForwarderService: DeepLinkForwarderService
    ) {
        self.notificationCenter = notificationCenter
        self.deepLinkForwarderService = deepLinkForwarderService
    }

    private var notificationCenter: UNUserNotificationCenter!
    private var deepLinkForwarderService: DeepLinkForwarderService!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        notificationCenter.delegate = self
        return true
    }

    // MARK: UNUserNotificationCenterDelegate

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        [.list, .banner, .sound]
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {
        guard let deepLink = deepLinkForwarderService.deepLink(for: response.notification.request.content.userInfo) else {
            return
        }
        deepLinkForwarderService.forwardDeepLink(deepLink)
    }

}

@preconcurrency import UserNotifications

public final class NotificationsService: ObservableObject, Sendable {

    public func getAuthorizationStatus() async -> UNAuthorizationStatus {
        await notificationCenter.notificationSettings().authorizationStatus
    }

    public func requestAuthorization() async -> Bool {
        (try? await notificationCenter.requestAuthorization(options: [.alert, .sound])) == true
    }

    public func sendNotification(title: String, body: String, userInfo: [AnyHashable: Any]) async throws {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = userInfo
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        try await notificationCenter.add(request)
    }

    private let notificationCenter: UNUserNotificationCenter

    public init(notificationCenter: UNUserNotificationCenter) {
        self.notificationCenter = notificationCenter
    }

}

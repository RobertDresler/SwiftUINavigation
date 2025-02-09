import Foundation
import SwiftUINavigation
@preconcurrency import Combine

public final class DeepLinkForwarderService: ObservableObject, Sendable {

    public func userInfo(for deepLink: ExamplesAppNavigationDeepLink) -> [AnyHashable: Any] {
        switch deepLink.destination {
        case .subscription:
            ["deepLink": "subscription"]
        }
    }

    public func deepLink(for userInfo: [AnyHashable: Any]) -> ExamplesAppNavigationDeepLink? {
        if let deepLink = userInfo["deepLink"] as? String {
            switch deepLink {
            case "subscription":
                ExamplesAppNavigationDeepLink(destination: .subscription(SubscriptionInputData()))
            default:
                nil
            }
        } else {
            nil
        }
    }

    public func forwardDeepLink(_ deepLink: ExamplesAppNavigationDeepLink) {
        deepLinkPublisher.send(deepLink)
    }

    public let deepLinkPublisher = PassthroughSubject<ExamplesAppNavigationDeepLink, Never>()

    public init() {}

}

import Foundation
import ExamplesNavigation
import SwiftUINavigation
@preconcurrency import Combine

public final class DeepLinkForwarderService: ObservableObject, Sendable {

    public func userInfo(for deepLink: ExamplesNavigationDeepLink) -> [AnyHashable: Any] {
        switch deepLink.destination {
        case .subscription:
            ["deepLink": "subscription"]
        }
    }

    public func deepLink(for userInfo: [AnyHashable: Any]) -> NavigationDeepLink? {
        if let deepLink = userInfo["deepLink"] as? String {
            switch deepLink {
            case "subscription":
                ExamplesNavigationDeepLink(destination: .subscription(SubscriptionInputData()))
            default:
                nil
            }
        } else {
            nil
        }
    }

    public func forwardDeepLink(_ deepLink: NavigationDeepLink) {
        deepLinkPublisher.send(deepLink)
    }

    public let deepLinkPublisher = PassthroughSubject<NavigationDeepLink, Never>()

    public init() {}

}

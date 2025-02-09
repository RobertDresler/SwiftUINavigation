import SwiftUINavigation
import Foundation

public struct ExamplesAppNavigationDeepLink {

    public enum Destination {
        case subscription(SubscriptionInputData)
    }

    public let destination: Destination

    public init(destination: Destination) {
        self.destination = destination
    }

}

import SwiftUINavigation
import Foundation

public struct ExamplesNavigationDeepLink: NavigationDeepLink {

    public indirect enum Destination: Hashable {
        case subscription(SubscriptionInputData)
    }

    public let destination: Destination

    public init(destination: Destination) {
        self.destination = destination
    }

}

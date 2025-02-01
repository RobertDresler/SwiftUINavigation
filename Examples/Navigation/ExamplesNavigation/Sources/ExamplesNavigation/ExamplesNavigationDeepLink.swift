import SwiftUINavigation
import Foundation

public struct ExamplesNavigationDeepLink {

    public indirect enum Destination {
        case subscription(SubscriptionInputData)
    }

    public let destination: Destination

    public init(destination: Destination) {
        self.destination = destination
    }

}

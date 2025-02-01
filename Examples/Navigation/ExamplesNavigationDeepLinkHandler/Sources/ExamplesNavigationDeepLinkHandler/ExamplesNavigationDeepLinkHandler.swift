import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Subscription
import FlagsRepository

@MainActor public final class ExamplesNavigationDeepLinkHandler: ObservableObject {

    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public func handleDeepLink(
        _ deepLink: ExamplesNavigationDeepLink,
        on node: any NavigationNode,
        messageListener: NavigationMessageListener? = nil
    ) {
        switch deepLink.destination {
        case .subscription(let inputData):
            let subscriptionNode = SubscriptionNavigationNode(
                inputData: inputData,
                flagsRepository: flagsRepository
            ).onMessageReceived(messageListener)
            node.execute(.present(.sheet(.stacked(subscriptionNode))))
        }
    }

}

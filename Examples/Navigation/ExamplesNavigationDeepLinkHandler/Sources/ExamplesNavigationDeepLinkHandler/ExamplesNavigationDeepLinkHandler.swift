import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Subscription
import FlagsRepository

public final class ExamplesNavigationDeepLinkHandler: NavigationDeepLinkHandler {

    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public func handleDeepLink(
        _ deepLink: NavigationDeepLink,
        on node: any NavigationNode,
        messageListener: NavigationMessageListener?
    ) {
        guard let deepLink = deepLink as? ExamplesNavigationDeepLink else { return }
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

import SwiftUINavigation
import FlagsRepository
import Subscription
import ExamplesNavigation

struct HandleNavigationDeepLinkCommand: NavigationCommand {

    func execute(on node: any NavigationNode) {
        switch deepLink.destination {
        case .subscription(let inputData):
            let subscriptionNode = SubscriptionNavigationNode(
                inputData: inputData,
                flagsRepository: flagsRepository
            ).onMessageReceived(messageListener)
            node.execute(.present(.sheet(.stacked(subscriptionNode))))
        }
    }

    func canExecute(on node: any NavigationNode) -> Bool {
        true
    }

    private let flagsRepository: FlagsRepository
    private let deepLink: ExamplesNavigationDeepLink
    private let messageListener: NavigationMessageListener?

    init(
        flagsRepository: FlagsRepository,
        deepLink: ExamplesNavigationDeepLink,
        messageListener: NavigationMessageListener?
    ) {
        self.flagsRepository = flagsRepository
        self.deepLink = deepLink
        self.messageListener = messageListener
    }

}

import SwiftUINavigation
import FlagsRepository
import Subscription
import ExamplesNavigation

struct HandleNavigationDeepLinkCommand: NavigationCommand {

    func execute(on model: any NavigationModel) {
        switch deepLink.destination {
        case .subscription(let inputData):
            let subscriptionModel = SubscriptionNavigationModel(
                inputData: inputData,
                flagsRepository: flagsRepository
            ).onMessageReceived(messageListener)
            model.execute(.present(.sheet(.stacked(subscriptionModel))))
        }
    }

    func canExecute(on model: any NavigationModel) -> Bool {
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

import SwiftUINavigation
import Subscription
import Shared

struct HandleDeepLinkNavigationCommand: NavigationCommand {

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

    private let flagsRepository: FlagsRepository
    private let deepLink: ExamplesAppNavigationDeepLink
    private let messageListener: NavigationMessageListener?

    init(
        flagsRepository: FlagsRepository,
        deepLink: ExamplesAppNavigationDeepLink,
        messageListener: NavigationMessageListener?
    ) {
        self.flagsRepository = flagsRepository
        self.deepLink = deepLink
        self.messageListener = messageListener
    }

}

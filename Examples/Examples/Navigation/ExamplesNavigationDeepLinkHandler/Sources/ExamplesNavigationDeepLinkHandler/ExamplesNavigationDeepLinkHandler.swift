import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Subscription
import UserRepository

public final class ExamplesNavigationDeepLinkHandler: NavigationDeepLinkHandler {

    private let userRepository: UserRepository

    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func handleDeepLink(
        _ deepLink: NavigationDeepLink,
        on node: NavigationNode,
        messageListener: NavigationNode.MessageListener?
    ) {
        guard let deepLink = deepLink as? ExamplesNavigationDeepLink else { return }
        switch deepLink.destination {
        case .subscription(let inputData):
            let subscriptionNode = SubscriptionNavigationNode(
                inputData: inputData,
                userRepository: userRepository
            )
            subscriptionNode.addMessageListener(messageListener)
            node.executeCommand(
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.stacked(
                        node: subscriptionNode
                    )
                )
            )
        }
    }

}

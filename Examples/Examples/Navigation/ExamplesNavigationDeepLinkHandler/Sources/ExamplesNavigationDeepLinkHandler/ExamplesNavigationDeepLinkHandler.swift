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

    public func handleDeepLink(_ deepLink: any NavigationDeepLink, on node: NavigationNode) {
        guard let deepLink = deepLink as? ExamplesNavigationDeepLink else { return }
        switch deepLink.destination {
        case .subscription(let inputData):
            node.executeCommand(
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.stacked(
                        node: SubscriptionNavigationNode(
                            inputData: inputData,
                            userRepository: userRepository
                        )
                    )
                )
            )
        }
    }

}

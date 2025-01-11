import SwiftUINavigation
import ExamplesNavigation
import Shared

struct FlowsActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "Flows"
    }

    func makeSubtitle() -> String? {
        "Explore example flows like Onboarding or Login/Logout. These are just a few—many more can be created! For commands like Present or Append, check the 'Commands' tab."
    }

    func makeItems() -> [ActionableListItem] {
        [
            logoutItem,
            onboardingItem,
            messagingBetweenNodesItem,
            sendNotificationItem,
            subscriptionItem
        ]
    }

    private var logoutItem: ActionableListItem {
        let presentingNavigationSourceID = "logout"
        return .new(
            id: presentingNavigationSourceID,
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "door.left.hand.open",
                accentColor: .indigo,
                title: "Logout",
                subtitle: "This flow shows how to handle logout with a confirmation alert. The switch logic is managed by AppNavigationNode, and you can easily log in again after logging out."
            ),
            customAction: .logout(sourceID: presentingNavigationSourceID),
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

    private var onboardingItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "hand.wave.fill",
                accentColor: .green,
                title: "Onboarding",
                subtitle: "This flow leads to the start screen, where onboarding begins. It demonstrates a form-like flow with data storage using OnboardingService and step-by-step navigation."
            ),
            customAction: .logoutWithConfirmation
        )
    }

    private var messagingBetweenNodesItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "bubble.left.and.bubble.right.fill",
                accentColor: .teal,
                title: "Messaging Between Nodes",
                subtitle: "This flow demonstrates messaging between nodes. When you confirm logout, a message is sent to the list node, which handles the logout after the confirmation dialog node is destroyed (RemovalNavigationMessage received)."
            ),
            customAction: .logoutWithCustomConfirmationDialog
        )
    }

    private var sendNotificationItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "bell.badge.fill",
                accentColor: .red,
                title: "Notification with Deep Link",
                subtitle: "Sends a notification that redirects to a deep link when tapped, called by DeepLinkForwarderService in AppDelegate and handled in AppNavigationNode."
            ),
            customAction: .sendNotification
        )
    }

    private var subscriptionItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "star.circle.fill",
                accentColor: .yellow,
                title: "Subscription",
                subtitle: "This flow shows a node based on a changing state—premium or freemium screen depending on the user's status"
            ),
            deepLink: ExamplesNavigationDeepLink(destination: .subscription(SubscriptionInputData()))
        )
    }

}

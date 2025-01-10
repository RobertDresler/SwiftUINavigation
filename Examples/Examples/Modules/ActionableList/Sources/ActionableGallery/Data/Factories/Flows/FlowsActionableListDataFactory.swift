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

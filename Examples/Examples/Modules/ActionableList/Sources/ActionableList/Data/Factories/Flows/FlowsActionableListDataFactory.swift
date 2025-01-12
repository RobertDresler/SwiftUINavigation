import SwiftUINavigation
import ExamplesNavigation
import Shared

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationNode` methods from the `View` or pass events to the `NavigationNode`. Check examples in **Architectures** flow for the correct approach.
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
            architecturesItem,
            subscriptionItem,
            windowsItem,
            requestReviewItem,
            lockAppItem,
            navigationNodeRelationshipsItem
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

    private var architecturesItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "cube.fill",
                accentColor: .purple,
                title: "Architectures",
                subtitle: "How SwiftUINavigation works with architectures like MVVM or Composable, helping you envision your code structure"
            ),
            makeCommand: {
                StackAppendNavigationCommand(
                    appendedNode: ActionableListNavigationNode(
                        inputData: ActionableListInputData(id: .architectures)
                    )
                )
            }
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

    private var lockAppItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "lock.fill",
                accentColor: .pink,
                title: "Lock App",
                subtitle: "This flow presents a lock screen over the whole app, a common pattern in many apps"
            ),
            customAction: .lockApp
        )
    }

    private var windowsItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "macwindow.on.rectangle",
                accentColor: .orange,
                title: "Window (iPad only)",
                subtitle: "This flow presents a second separate window, managed by AppNavigationNode using NavigationEnvironmentTriggers"
            ),
            customAction: .openWaitingWindow
        )
    }

    private var requestReviewItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "star.bubble.fill",
                accentColor: .blue,
                title: "Request Review",
                subtitle: "You can create a custom NavigationEnvironmentTrigger to invoke an EnvironmentValues action, such as requestReview. Due to SwiftUI limitations, this action must be proxied (see AppWindow for reference). Similarly, actions like openURL or openWindow follow the same pattern."
            ),
            makeCommand: { RequestReviewNavigationCommand() }
        )
    }

    private var navigationNodeRelationshipsItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "point.3.filled.connected.trianglepath.dotted",
                accentColor: .gray,
                title: "NavigationNode Relationships",
                subtitle: "Navigation nodes create a graph with parent-child relationships, making it easy to track the flow. Shake your phone or use the simulator (Device -> Shake) to print the node hierarchy from the Root (AppNavigationNode) into the terminal."
            ),
            customAction: .printDebugGraph
        )
    }

}

import SwiftUINavigation
import ExamplesNavigation
import Shared
import SegmentedTabs
import CustomNavigationBar
import DeepLinkForwarderService
import NotificationsService
import FlagsRepository
import ArchitectureExample

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationModel` methods from the `View` or pass events to the `NavigationModel`. Check examples in **Architectures** flow for the correct approach.
struct FlowsActionableListDataFactory: ActionableListDataFactory {

    var deepLinkForwarderService: DeepLinkForwarderService
    var notificationsService: NotificationsService
    var flagsRepository: FlagsRepository
    
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
            messagingBetweenModelsItem,
            sendNotificationItem,
            architecturesItem,
            subscriptionItem,
            windowsItem,
            requestReviewItem,
            navigationBarCustomizationItem,
            lockAppItem,
            customWrapperItem,
            navigationModelRelationshipsItem
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
                subtitle: "This flow shows how to handle logout with a confirmation alert. The switch logic is managed by AppNavigationModel, and you can easily log in again after logging out."
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

    private var messagingBetweenModelsItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "bubble.left.and.bubble.right.fill",
                accentColor: .teal,
                title: "Messaging Between Models",
                subtitle: "This flow demonstrates messaging between models. When you confirm logout, a message is sent to the list model, which handles the logout after the confirmation dialog model is destroyed (RemovalNavigationMessage received)."
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
                subtitle: "Sends a notification that redirects to a deep link when tapped, called by DeepLinkForwarderService in AppDelegate and handled in AppNavigationModel."
            ),
            customAction: .sendNotification
        )
    }

    private var architecturesItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "point.topleft.filled.down.to.point.bottomright.curvepath",
                accentColor: .purple,
                title: "Architecture",
                subtitle: "Starting from SwiftUINavigation 2.0.0, the preferred architecture is MV (Model-View). However, you can still adapt it to fit your needs."
            ),
            makeCommand: {
                .stackAppend(
                    ArchitectureExampleNavigationModel(inputData: ArchitectureExampleInputData(initialName: "Anna"))
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
                subtitle: "This flow shows a model based on a changing state—premium or freemium screen depending on the user's status"
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
                subtitle: "This flow presents a second separate window, managed by AppNavigationModel using NavigationEnvironmentTriggers"
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

    private var navigationBarCustomizationItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "menubar.rectangle",
                accentColor: .mint,
                title: "Navigation Bar Customization",
                subtitle: "The best way to customize the navigation bar is by creating your own"
            ),
            makeCommand: {
                .stackAppend(CustomNavigationBarNavigationModel())
            }
        )
    }

    private var customWrapperItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "circle.grid.2x1.left.filled",
                accentColor: .brown,
                title: "Segmented Tabs",
                subtitle: "You can create custom wrapper view just like StackRootNavigationModel or TabsRootNavigationModel"
            ),
            makeCommand: {
                .stackAppend(
                    SegmentedTabsNavigationModel(
                        tabs: [
                            SegmentedTab(
                                name: "View Only",
                                model: ArchitectureExampleNavigationModel(inputData: ArchitectureExampleInputData(initialName: "Anna"))
                            ),
                            SegmentedTab(
                                name: "MVVM",
                                model: ArchitectureExampleNavigationModel(inputData: ArchitectureExampleInputData(initialName: "Robert"))
                            ),
                            SegmentedTab(
                                name: "Composable",
                                model: ArchitectureExampleNavigationModel(inputData: ArchitectureExampleInputData(initialName: "Thomas"))
                            )
                        ]
                    )
                )
            }
        )
    }

    private var navigationModelRelationshipsItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "point.3.filled.connected.trianglepath.dotted",
                accentColor: .gray,
                title: "NavigationModel Relationships",
                subtitle: "Navigation models create a graph with parent-child relationships, making it easy to track the flow. Shake your phone or use the simulator (Device -> Shake) to print the model hierarchy from the root into the terminal (handled by AppWindow)."
            ),
            customAction: .printDebugGraph
        )
    }

}

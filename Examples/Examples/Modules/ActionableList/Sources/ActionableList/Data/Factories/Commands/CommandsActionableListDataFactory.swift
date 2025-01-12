import SwiftUINavigation
import ExamplesNavigation
import Shared

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationNode` methods from the `View` or pass events to the `NavigationNode`. Check examples in **Architectures** flow for the correct approach.
struct CommandsActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "Commands"
    }

    func makeSubtitle() -> String? {
        "Explore various commands like Present, Append, and more. For flows like Onboarding, Login/Logout or Notifications, check the 'Flows' tab."
    }

    func makeItems() -> [ActionableListItem] {
        [
            modalsTraditionalItem,
            modalsSpecialItem,
            stackItem,
            hideItem,
            urlHandlingItem,
            selectTabsItemItem,
            customCommandItem,
            deepLinkItem
        ]
    }

    private var modalsTraditionalItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus.fill",
                accentColor: .blue,
                title: "Modals - Traditional",
                subtitle: "Full Screen Covers and Sheets"
            ),
            makeCommand: makeAppendActionableListCommand(for: .modalsTraditional)
        )
    }

    private var modalsSpecialItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "exclamationmark.bubble.fill",
                accentColor: .pink,
                title: "Modals - Special",
                subtitle: "Alert, Confirmation Dialog, PhotoPicker, UIViewControllerRepresentable"
            ),
            makeCommand: makeAppendActionableListCommand(for: .modalsSpecial)
        )
    }

    private var stackItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "square.stack.3d.down.right.fill",
                accentColor: .purple,
                title: "Stack",
                subtitle: "Commands for managing navigation stack path - append, drop last, set root, ..."
            ),
            makeCommand: makeAppendActionableListCommand(for: .stack)
        )
    }

    private var hideItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.fill.badge.minus",
                accentColor: .teal,
                title: "Hide",
                subtitle: "Drops the last item in the stack, or dismisses if there is nothing to drop"
            ),
            makeCommand: {
                ResolvedHideNavigationCommand()
            }
        )
    }

    private var urlHandlingItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "link",
                accentColor: .brown,
                title: "URL Handling",
                subtitle: "Open URL, redirect to other apps, SFSafari"
            ),
            makeCommand: makeAppendActionableListCommand(for: .urlHandling)
        )
    }

    private var selectTabsItemItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.split.3x1.fill",
                accentColor: .green,
                title: "Select Tabs Item",
                subtitle: "Use TabsSelectItemNavigationCommand with a specific ID to select the flows tab"
            ),
            makeCommand: {
                TabsSelectItemNavigationCommand(itemID: MainTabsInputData.Tab.flows)
            }
        )
    }

    private var customCommandItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "wrench.and.screwdriver.fill",
                accentColor: .yellow,
                title: "Custom Command (Show View and Automatically Hide After 2s)",
                subtitle: "Easily create a custom command like ShowAndHideAfterDelayNavigationCommand to achieve this behavior"
            ),
            makeCommand: {
                ShowAndHideAfterDelayNavigationCommand(
                    presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                        node: ActionableListNavigationNode(inputData: .default)
                    ),
                    hideDelay: 2
                )
            }
        )
    }

    private var deepLinkItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "arrow.up.and.down.and.arrow.left.and.right",
                accentColor: .orange,
                title: "Deep Link",
                subtitle: "The Deep Link feature enables routing between modules without direct dependency. You can verify that this module doesn't depend on the Subscription module, as routing is handled by ExamplesNavigationDeepLinkHandler."
            ),
            deepLink: ExamplesNavigationDeepLink(destination: .subscription(SubscriptionInputData()))
        )
    }

    private func makeAppendActionableListCommand(for id: ActionableListInputData.ID) -> () -> NavigationCommand {
        {
            StackAppendNavigationCommand(
                appendedNode: ActionableListNavigationNode(
                    inputData: ActionableListInputData(id: id)
                )
            )
        }
    }


}

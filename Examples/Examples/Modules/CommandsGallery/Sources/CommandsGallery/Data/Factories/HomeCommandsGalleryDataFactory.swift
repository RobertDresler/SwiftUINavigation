import SwiftUINavigation
import ExamplesNavigation
import Shared

struct HomeCommandsGalleryDataFactory: CommandsGalleryDataFactory {

    func makeTitle() -> String {
        "Commands Gallery"
    }
    
    func makeItems() -> [CommandsGalleryItem] {
        [
            modalsTraditionalItem,
            modalsSpecialItem,
            stackItem,
            hideItem,
            urlHandlingItem,
            selectTabsItemItem,
            customCommandItem
        ]
    }

    private var modalsTraditionalItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus.fill",
                accentColor: .blue,
                title: "Modals - Traditional",
                subtitle: "Full Screen Covers and Sheets"
            ),
            makeCommand: makeAppendCommandsGalleryCommand(for: .modalsTraditional)
        )
    }

    private var modalsSpecialItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "exclamationmark.bubble.fill",
                accentColor: .pink,
                title: "Modals - Special",
                subtitle: "Alert, Confirmation Dialog, PhotoPicker"
            ),
            makeCommand: makeAppendCommandsGalleryCommand(for: .modalsSpecial)
        )
    }

    private var stackItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "square.stack.3d.down.right.fill",
                accentColor: .purple,
                title: "Stack",
                subtitle: "Commands for managing navigation stack path - append, drop last, set root, ..."
            ),
            makeCommand: makeAppendCommandsGalleryCommand(for: .stack)
        )
    }

    private var hideItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
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

    private var urlHandlingItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "link",
                accentColor: .brown,
                title: "URL Handling",
                subtitle: "Open URL, redirect to other apps, SFSafari"
            ),
            makeCommand: makeAppendCommandsGalleryCommand(for: .urlHandling)
        )
    }

    private var selectTabsItemItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "rectangle.split.3x1.fill",
                accentColor: .green,
                title: "Select Tabs Item",
                subtitle: "Use TabsSelectItemNavigationCommand with a specific ID to select the settings tab"
            ),
            makeCommand: {
                TabsSelectItemNavigationCommand(itemID: MainTabsInputData.Tab.settings)
            }
        )
    }

    private var customCommandItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "wrench.and.screwdriver.fill",
                accentColor: .yellow,
                title: "Custom Command (Show View and Automatically Hide After 2s)",
                subtitle: "Easily create a custom command like ShowAndHideAfterDelayNavigationCommand to achieve this behavior"
            ),
            makeCommand: {
                ShowAndHideAfterDelayNavigationCommand(
                    presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                        node: CommandsGalleryNavigationNode(inputData: .default)
                    ),
                    hideDelay: 2
                )
            }
        )
    }

    private func makeAppendCommandsGalleryCommand(for id: CommandsGalleryInputData.ID) -> () -> NavigationCommand {
        {
            StackAppendNavigationCommand(
                appendedNode: StackNavigationNode(
                    destination: CommandsGalleryNavigationNode(
                        inputData: CommandsGalleryInputData(id: id)
                    )
                )
            )
        }
    }


}

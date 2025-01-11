import SwiftUINavigation
import ExamplesNavigation
import Shared

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationNode` methods from the `View` or pass events to the `NavigationNode`. Check examples in **Architectures** flow for the correct approach.
struct ModalsSpecialActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "Modals - Special"
    }
    
    func makeItems() -> [ActionableListItem] {
        [
            showAlertItem,
            showConfirmationDialogItem,
            showPhotosPickerItem
        ]
    }

    private var showAlertItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "exclamationmark.bubble.fill",
                accentColor: .red,
                title: "Show Alert"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: AlertPresentedNavigationNode(
                        inputData: AlertInputData(
                            title: "Oops, Something Went Wrong!",
                            message: "We tried to make it work, but it seems like everything fell apart. Should we try again, or just give up?",
                            actions: [
                                AlertInputData.Action(
                                    id: "cancel",
                                    title: "Cancel",
                                    role: .cancel,
                                    handler: { print("Okay, you're in charge. We'll just cancel this mess.") }
                                ),
                                AlertInputData.Action(
                                    id: "giveUp",
                                    title: "Give Up",
                                    role: .destructive,
                                    handler: { print("We’re done here. Time to just cry in peace.") }
                                )
                            ]
                        )
                    )
                )
            }
        )
    }

    private var showConfirmationDialogItem: ActionableListItem {
        let presentingNavigationSourceID = "confirmationDialog"
        return .new(
            id: presentingNavigationSourceID,
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "questionmark.bubble.fill",
                accentColor: .red,
                title: "Show Confirmation Dialog",
                subtitle: "Note that by using the sourceID and presentingNavigationSource(_:), it is presented as a popover from the card on iPadOS"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: ConfirmationDialogPresentedNavigationNode(
                        inputData: ConfirmationDialogInputData(
                            message: "Are you sure you want to delete all your hard work? You can always undo, but who has time for that, right?",
                            actions: [
                                ConfirmationDialogInputData.Action(
                                    id: "confirm",
                                    title: "Yes, Let's Do It!",
                                    role: .destructive,
                                    handler: { print("Well, that's one way to clear everything... Let's start over.") }
                                ),
                                ConfirmationDialogInputData.Action(
                                    id: "cancel",
                                    title: "No, I Changed My Mind",
                                    role: .cancel,
                                    handler: { print("Phew! Dodged a bullet. Let's pretend that never happened.") }
                                )
                            ]
                        ),
                        sourceID: presentingNavigationSourceID
                    )
                )
            },
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

    private var showPhotosPickerItem: ActionableListItem {
        let presentingNavigationSourceID = "photosPicker"
        return .new(
            id: presentingNavigationSourceID,
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "person.2.crop.square.stack.fill",
                accentColor: .red,
                title: "Photos Picker",
                subtitle: "Since the Photos Picker is a custom PresentedNavigationNode, it must be registered using registerCustomPresentableNavigationNodes(_:) on the NavigationWindow"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: PhotosPickerPresentedNavigationNode(
                        inputData: PhotosPickerInputData(
                            maxSelectionCount: 3,
                            photosPickerItem: []
                        ),
                        sourceID: presentingNavigationSourceID
                    )
                )
            },
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

}

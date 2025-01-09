import SwiftUINavigation
import ExamplesNavigation

struct ModalsAlertsCommandsGalleryDataFactory: CommandsGalleryDataFactory {

    func makeTitle() -> String {
        "Modals - Alerts"
    }
    
    func makeItems() -> [CommandsGalleryItem] {
        [
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
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
            ),
            .new(
                id: confirmationDialogPresentingNavigationSourceID,
                viewModel: CommandsGalleryItemView.ViewModel(
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
                            sourceID: confirmationDialogPresentingNavigationSourceID
                        )
                    )
                },
                presentingNavigationSourceID: confirmationDialogPresentingNavigationSourceID
            )
        ]
    }

    private var confirmationDialogPresentingNavigationSourceID: String {
        "confirmationDialog"
    }


}

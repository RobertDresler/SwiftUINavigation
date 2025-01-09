import SwiftUINavigation
import ExamplesNavigation

struct HomeCommandsGalleryDataFactory: CommandsGalleryDataFactory {

    func makeTitle() -> String {
        "Commands Gallery"
    }
    
    func makeItems() -> [CommandsGalleryItem] {
        [
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.portrait.badge.plus.fill",
                    accentColor: .blue,
                    title: "Modals - Traditional",
                    subtitle: "Full Screen Covers and Sheets"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(
                                inputData: CommandsGalleryInputData(id: .modalsTraditional)
                            )
                        )
                    )
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "exclamationmark.bubble.fill",
                    accentColor: .red,
                    title: "Modals - Alerts",
                    subtitle: "Alerts and Confirmation Dialogs"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(
                                inputData: CommandsGalleryInputData(id: .modalsAlerts)
                            )
                        )
                    )
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "square.stack.3d.down.right.fill",
                    accentColor: .purple,
                    title: "Stack",
                    subtitle: "Commands for managing navigation stack path - append, drop last, set root, ..."
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(
                                inputData: CommandsGalleryInputData(id: .stack)
                            )
                        )
                    )
                }
            ),
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
        ]
    }


}

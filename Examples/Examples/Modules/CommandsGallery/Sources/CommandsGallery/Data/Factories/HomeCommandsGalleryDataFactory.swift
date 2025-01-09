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
                    title: "Modal Commands",
                    subtitle: "Full Screen Covers, Sheets, and More for Managing Modal Presentations"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(
                                inputData: CommandsGalleryInputData(id: .modal)
                            ),
                            transition: nil
                        )
                    )
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "square.stack.3d.down.right.fill",
                    accentColor: .purple,
                    title: "Stack Commands",
                    subtitle: "Commands for managing navigation stack actions, including push, pop, and more"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(
                                inputData: CommandsGalleryInputData(id: .stack)
                            ),
                            transition: nil
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

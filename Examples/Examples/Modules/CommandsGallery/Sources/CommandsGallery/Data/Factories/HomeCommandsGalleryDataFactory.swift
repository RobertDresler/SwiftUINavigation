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
            )
        ]
    }


}

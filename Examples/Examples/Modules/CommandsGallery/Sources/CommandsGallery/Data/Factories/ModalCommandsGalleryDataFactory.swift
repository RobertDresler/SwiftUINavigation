import SwiftUINavigation
import ExamplesNavigation

struct ModalCommandsGalleryDataFactory: CommandsGalleryDataFactory {

    func makeTitle() -> String {
        "Modal Commands"
    }
    
    func makeItems() -> [CommandsGalleryItem] {
        [
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.portrait.badge.plus.fill",
                    accentColor: .blue,
                    title: "Present Full Screen Cover"
                ),
                makeCommand: {
                    PresentNavigationCommand(
                        presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                            node: CommandsGalleryNavigationNode(inputData: .default)
                        )
                    )
                }
            )//,
            /*.new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.stack.fill.badge.plus",
                    accentColor: .blue,
                    title: "Present Sheet"
                ),
                deepLink: PresentNavigationCommand(
                    presentedNode: sheetno(
                        node: CommandsGalleryNavigationNode(inputData: .default)
                    )
                )
            )*/
        ]
    }


}

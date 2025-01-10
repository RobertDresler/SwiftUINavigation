import SwiftUINavigation
import ExamplesNavigation

struct ModalsTraditionalCommandsGalleryDataFactory: CommandsGalleryDataFactory {

    func makeTitle() -> String {
        "Modals - Traditional"
    }
    
    func makeItems() -> [CommandsGalleryItem] {
        [
            presentFullScreenCoverItem,
            presentFullScreenCoverWithoutAnimationItem,
            presentSheetItem,
            presentBottomSheetItem,
            dismissItem
        ]
    }

    private var presentFullScreenCoverItem: CommandsGalleryItem {
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
        )
    }

    private var presentFullScreenCoverWithoutAnimationItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus",
                accentColor: .blue,
                title: "Present Full Screen Cover",
                subtitle: "Without Animation"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                        node: CommandsGalleryNavigationNode(inputData: .default)
                    ),
                    animated: false
                )
            }
        )
    }

    private var presentSheetItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "rectangle.stack.fill.badge.plus",
                accentColor: .blue,
                title: "Present Sheet"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.stacked(
                        node: CommandsGalleryNavigationNode(inputData: .default)
                    )
                )
            }
        )
    }

    private var presentBottomSheetItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "inset.filled.bottomhalf.rectangle.portrait",
                accentColor: .blue,
                title: "Present Sheet",
                subtitle: "...with Medium detent (Bottom Sheet)"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.stacked(
                        node: CommandsGalleryNavigationNode(
                            inputData: CommandsGalleryInputData(
                                id: .home,
                                addPresentationDetents: true
                            )
                        )
                    )
                )
            }
        )
    }

    private var dismissItem: CommandsGalleryItem {
        .new(
            viewModel: CommandsGalleryItemView.ViewModel(
                symbolName: "xmark.circle",
                accentColor: .blue,
                title: "Dismiss"
            ),
            makeCommand: {
                DismissNavigationCommand()
            }
        )
    }


}

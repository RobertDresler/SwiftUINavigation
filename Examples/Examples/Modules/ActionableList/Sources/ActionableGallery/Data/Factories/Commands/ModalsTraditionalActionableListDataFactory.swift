import SwiftUINavigation
import ExamplesNavigation

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationNode` methods from the `View` or pass events to the `NavigationNode`. Check examples in **Architectures** flow for the correct approach.
struct ModalsTraditionalActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "Modals - Traditional"
    }
    
    func makeItems() -> [ActionableListItem] {
        [
            presentFullScreenCoverItem,
            presentFullScreenCoverWithoutAnimationItem,
            presentSheetItem,
            presentBottomSheetItem,
            dismissItem
        ]
    }

    private var presentFullScreenCoverItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus.fill",
                accentColor: .blue,
                title: "Present Full Screen Cover"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                        node: ActionableListNavigationNode(inputData: .default)
                    )
                )
            }
        )
    }

    private var presentFullScreenCoverWithoutAnimationItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus",
                accentColor: .blue,
                title: "Present Full Screen Cover",
                subtitle: "Without Animation"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                        node: ActionableListNavigationNode(inputData: .default)
                    ),
                    animated: false
                )
            }
        )
    }

    private var presentSheetItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.fill.badge.plus",
                accentColor: .blue,
                title: "Present Sheet"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.stacked(
                        node: ActionableListNavigationNode(inputData: .default)
                    )
                )
            }
        )
    }

    private var presentBottomSheetItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "inset.filled.bottomhalf.rectangle.portrait",
                accentColor: .blue,
                title: "Present Sheet",
                subtitle: "...with Medium detent (Bottom Sheet)"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.stacked(
                        node: ActionableListNavigationNode(
                            inputData: ActionableListInputData(
                                id: .commands,
                                addPresentationDetents: true
                            )
                        )
                    )
                )
            }
        )
    }

    private var dismissItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
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

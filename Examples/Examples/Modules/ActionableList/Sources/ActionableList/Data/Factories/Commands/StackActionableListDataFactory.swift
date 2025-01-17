import SwiftUINavigation
import ExamplesNavigation
import Shared

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationNode` methods from the `View` or pass events to the `NavigationNode`. Check examples in **Architectures** flow for the correct approach.
struct StackActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "Stack"
    }
    
    func makeItems() -> [ActionableListItem] {
        [
            appendItem,
            appendWithoutAnimationItem,
            appendWithZoomTransitionItem,
            setThisAsRootItem,
            replaceRootItem,
            dropLastItem,
            dropLastWithoutAnimationItem,
            dropToRootItem,
            dropLast3Item,
            reversePathItem
        ]
    }

    private var appendItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.fill.badge.plus",
                accentColor: .purple,
                title: "Append"
            ),
            makeCommand: {
                StackAppendNavigationCommand(
                    appendedNode: ActionableListNavigationNode(inputData: .default)
                )
            }
        )
    }

    private var appendWithoutAnimationItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.badge.plus",
                accentColor: .purple,
                title: "Append",
                subtitle: "Without Animation"
            ),
            makeCommand: {
                StackAppendNavigationCommand(
                    appendedNode: ActionableListNavigationNode(inputData: .default),
                    animated: false
                )
            }
        )
    }

    private var appendWithZoomTransitionItem: ActionableListItem {
        let transitionID = "appendWithTransition"
        return .new(
            id: transitionID,
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "plus.magnifyingglass",
                accentColor: .purple,
                title: "Append",
                subtitle: "With Zoom Transition (iOS 18+)"
            ),
            makeCommand: {
                StackAppendNavigationCommand(
                    appendedNode: StackNavigationNode(
                        destination: ActionableListNavigationNode(inputData: .default),
                        transition: .zoom(sourceID: transitionID)
                    )
                )
            }
        )
    }

    private var setThisAsRootItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.fill",
                accentColor: .purple,
                title: "Set This As Root",
                subtitle: "...and clear path"
            ),
            makeCommand: { node in
                StackSetRootNavigationCommand(rootNode: node, clear: true)
            }
        )
    }

    private var replaceRootItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.fill.on.rectangle.angled.fill",
                accentColor: .purple,
                title: "Replace Root with new Stack Commands Gallery",
                subtitle: "...and keep path"
            ),
            makeCommand: {
                StackSetRootNavigationCommand(
                    rootNode: ActionableListNavigationNode(inputData: ActionableListInputData(id: .stack)),
                    clear: false
                )
            }
        )
    }

    private var dropLastItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.fill.badge.minus",
                accentColor: .purple,
                title: "Drop Last"
            ),
            makeCommand: {
                StackDropLastNavigationCommand()
            }
        )
    }

    private var dropLastWithoutAnimationItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.badge.minus",
                accentColor: .purple,
                title: "Drop Last",
                subtitle: "Without Animation"
            ),
            makeCommand: {
                StackDropLastNavigationCommand(animated: false)
            }
        )
    }

    private var dropToRootItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "house.fill",
                accentColor: .purple,
                title: "Drop To Root"
            ),
            makeCommand: {
                StackDropToRootNavigationCommand()
            }
        )
    }

    private var dropLast3Item: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "square.3.layers.3d.down.right.slash",
                accentColor: .purple,
                title: "Drop Last 3",
                subtitle: "...or less"
            ),
            makeCommand: {
                StackDropLastNavigationCommand(k: 3)
            }
        )
    }

    private var reversePathItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "arrow.trianglehead.2.clockwise.rotate.90",
                accentColor: .purple,
                title: "Reverse Path (Custom StackMap Command)",
                subtitle: "Explore the custom StackReverseNavigationCommand, built using the predefined StackMapNavigationCommand"
            ),
            makeCommand: {
                StackReverseNavigationCommand()
            }
        )
    }

}

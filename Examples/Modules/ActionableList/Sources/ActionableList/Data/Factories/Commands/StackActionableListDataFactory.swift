import SwiftUINavigation
import ExamplesNavigation
import Shared
import DeepLinkForwarderService
import NotificationsService
import FlagsRepository

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationModel` methods from the `View` or pass events to the `NavigationModel`. Check examples in **Architectures** flow for the correct approach.
struct StackActionableListDataFactory: ActionableListDataFactory {

    var deepLinkForwarderService: DeepLinkForwarderService
    var notificationsService: NotificationsService
    var flagsRepository: FlagsRepository
    
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
                .stackAppend(
                    ActionableListNavigationModel(
                        inputData: .default,
                        deepLinkForwarderService: deepLinkForwarderService,
                        notificationsService: notificationsService,
                        flagsRepository: flagsRepository
                    )
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
                .stackAppend(
                    ActionableListNavigationModel(
                        inputData: .default,
                        deepLinkForwarderService: deepLinkForwarderService,
                        notificationsService: notificationsService,
                        flagsRepository: flagsRepository
                    ),
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
                .stackAppend(
                    StackNavigationModel(
                        destination: ActionableListNavigationModel(
                            inputData: .default,
                            deepLinkForwarderService: deepLinkForwarderService,
                            notificationsService: notificationsService,
                            flagsRepository: flagsRepository
                        ),
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
            makeCommand: { model in
                .stackSetRoot(model, clear: true)
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
                .stackSetRoot(
                    ActionableListNavigationModel(
                        inputData: ActionableListInputData(id: .stack),
                        deepLinkForwarderService: deepLinkForwarderService,
                        notificationsService: notificationsService,
                        flagsRepository: flagsRepository
                    ),
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
                .stackDropLast()
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
                .stackDropLast(animated: false)
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
                .stackDropToRoot()
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
                .stackDropLast(3)
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

import SwiftUINavigation
import ExamplesNavigation
import Shared

struct StackCommandsGalleryDataFactory: CommandsGalleryDataFactory {

    func makeTitle() -> String {
        "Stack"
    }
    
    func makeItems() -> [CommandsGalleryItem] {
        [
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.stack.fill.badge.plus",
                    accentColor: .purple,
                    title: "Append"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(inputData: .default)
                        )
                    )
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.stack.badge.plus",
                    accentColor: .purple,
                    title: "Append",
                    subtitle: "Without Animation"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(inputData: .default)
                        ),
                        animated: false
                    )
                }
            ),
            .new(
                id: appendWithTransitionID,
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "plus.magnifyingglass",
                    accentColor: .purple,
                    title: "Append",
                    subtitle: "With Zoom Transition (iOS 18+)"
                ),
                makeCommand: {
                    StackAppendNavigationCommand(
                        appendedNode: StackNavigationNode(
                            destination: CommandsGalleryNavigationNode(inputData: .default),
                            transition: .zoom(sourceID: appendWithTransitionID)
                        )
                    )
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.fill",
                    accentColor: .purple,
                    title: "Set This As Root",
                    subtitle: "...and clear path"
                ),
                makeCommand: { node in
                    StackSetRootNavigationCommand(rootNode: node, clear: true)
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.fill.on.rectangle.angled.fill",
                    accentColor: .purple,
                    title: "Replace Root with new Stack Commands Gallery",
                    subtitle: "...and keep path"
                ),
                makeCommand: {
                    StackSetRootNavigationCommand(
                        rootNode: CommandsGalleryNavigationNode(inputData: CommandsGalleryInputData(id: .stack)),
                        clear: false
                    )
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.stack.fill.badge.minus",
                    accentColor: .purple,
                    title: "Drop Last"
                ),
                makeCommand: {
                    StackDropLastNavigationCommand()
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "rectangle.stack.badge.minus",
                    accentColor: .purple,
                    title: "Drop Last",
                    subtitle: "Without Animation"
                ),
                makeCommand: {
                    StackDropLastNavigationCommand(animated: false)
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "house.fill",
                    accentColor: .purple,
                    title: "Drop To Root"
                ),
                makeCommand: {
                    StackDropToRootNavigationCommand()
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "square.3.layers.3d.down.right.slash",
                    accentColor: .purple,
                    title: "Drop Last 3",
                    subtitle: "...or less"
                ),
                makeCommand: {
                    StackDropLastNavigationCommand(k: 3)
                }
            ),
            .new(
                viewModel: CommandsGalleryItemView.ViewModel(
                    symbolName: "arrow.trianglehead.2.clockwise.rotate.90",
                    accentColor: .purple,
                    title: "Reverse Path (Custom StackMap Command)",
                    subtitle: "Explore the custom StackReverseNavigationCommand, built using the predefined StackMapNavigationCommand"
                ),
                makeCommand: {
                    StackReverseNavigationCommand()
                }
            )
        ]
    }

    private var appendWithTransitionID: String {
        "appendWithTransition"
    }


}

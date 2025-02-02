import SwiftUINavigation
import ExamplesNavigation
import Shared
import ArchitectureViewOnly
import ArchitectureMVVM
import ArchitectureComposable

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationModel` methods from the `View` or pass events to the `NavigationModel`. Check examples in **Architectures** flow for the correct approach.
struct ArchitecturesActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "Architectures"
    }

    func makeSubtitle() -> String? {
        "These examples show how SwiftUINavigation can be used in different architectures. However, you have the freedom to choose any architecture you prefer. SwiftUINavigation simply handles navigation between screens (models); the architectural approach is entirely up to you. You don’t even have to pass input data to each model if you prefer."
    }

    func makeItems() -> [ActionableListItem] {
        [
            viewOnlyItem,
            mvvmItem,
            composableItem
        ]
    }

    private var viewOnlyItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "circle.fill",
                accentColor: .purple,
                title: "View Only",
                subtitle: "Architecture where everything is handled within the View"
            ),
            makeCommand: {
                .stackAppend(
                    ArchitectureViewOnlyNavigationModel(
                        inputData: ArchitectureViewOnlyInputData(
                            initialName: "Anna"
                        )
                    )
                )
            }
        )
    }

    private var mvvmItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "point.3.filled.connected.trianglepath.dotted",
                accentColor: .purple,
                title: "MVVM",
                subtitle: "A pattern that separates the UI (View) from the business logic (ViewModel), and events are sent to NavigationModel using eventHandler"
            ),
            makeCommand: {
                .stackAppend(
                    ArchitectureMVVMNavigationModel(
                        inputData: ArchitectureMVVMInputData(
                            initialName: "Anna"
                        )
                    )
                )
            }
        )
    }

    private var composableItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "arrow.2.squarepath",
                accentColor: .purple,
                title: "Composable-inspired",
                subtitle: "Architecture where state is modified by actions, and the UI updates based on the state changes, and events are sent to NavigationModel using eventHandler"
            ),
            makeCommand: {
                .stackAppend(
                    ArchitectureComposableNavigationModel(
                        inputData: ArchitectureComposableInputData(
                            initialName: "Anna"
                        )
                    )
                )
            }
        )
    }

}

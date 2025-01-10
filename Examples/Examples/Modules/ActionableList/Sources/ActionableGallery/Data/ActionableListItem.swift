import ExamplesNavigation
import Shared
import Foundation
import SwiftUINavigation

@MainActor
struct ActionableListItem {
    let identifiableViewModel: IdentifiableViewModel<String, ActionableListItemView.ViewModel>
    let makeCommand: (NavigationNode) -> NavigationCommand
    let presentingNavigationSourceID: String?
}

extension ActionableListItem {
    static func new(
        id: String = UUID().uuidString,
        viewModel: ActionableListItemView.ViewModel,
        makeCommand: @escaping (NavigationNode) -> NavigationCommand,
        presentingNavigationSourceID: String? = nil
    ) -> ActionableListItem {
        ActionableListItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            makeCommand: makeCommand,
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

    static func new(
        id: String = UUID().uuidString,
        viewModel: ActionableListItemView.ViewModel,
        makeCommand: @escaping () -> NavigationCommand,
        presentingNavigationSourceID: String? = nil
    ) -> ActionableListItem {
        ActionableListItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            makeCommand: { _ in makeCommand() },
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

    static func new(
        id: String = UUID().uuidString,
        viewModel: ActionableListItemView.ViewModel,
        deepLink: any NavigationDeepLink,
        presentingNavigationSourceID: String? = nil
    ) -> ActionableListItem {
        ActionableListItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            makeCommand: { _ in DefaultHandleDeepLinkNavigationCommand(deepLink: deepLink) },
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }
}

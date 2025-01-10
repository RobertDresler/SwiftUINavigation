import ExamplesNavigation
import Shared
import Foundation
import SwiftUINavigation

@MainActor
struct ActionableListItem {

    enum Action {

        enum CustomAction {
            case logout(sourceID: String)
            case sendNotification
            case logoutWithCustomConfirmationDialog
        }

        case command(makeCommand: (NavigationNode) -> NavigationCommand)
        case custom(CustomAction)

    }

    let identifiableViewModel: IdentifiableViewModel<String, ActionableListItemView.ViewModel>
    let action: Action
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
            action: .command(makeCommand: makeCommand),
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
            action: .command(makeCommand: { _ in makeCommand() }),
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

    static func new(
        id: String = UUID().uuidString,
        viewModel: ActionableListItemView.ViewModel,
        deepLink: NavigationDeepLink,
        presentingNavigationSourceID: String? = nil
    ) -> ActionableListItem {
        ActionableListItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            action: .command(makeCommand: { _ in DefaultHandleDeepLinkNavigationCommand(deepLink: deepLink) }),
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }

    static func new(
        id: String = UUID().uuidString,
        viewModel: ActionableListItemView.ViewModel,
        customAction: Action.CustomAction,
        presentingNavigationSourceID: String? = nil
    ) -> ActionableListItem {
        ActionableListItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            action: .custom(customAction),
            presentingNavigationSourceID: presentingNavigationSourceID
        )
    }
}

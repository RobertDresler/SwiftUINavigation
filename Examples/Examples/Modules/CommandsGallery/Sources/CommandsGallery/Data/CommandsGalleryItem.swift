import ExamplesNavigation
import Shared
import Foundation
import SwiftUINavigation

struct CommandsGalleryItem {
    let identifiableViewModel: IdentifiableViewModel<String, CommandsGalleryItemView.ViewModel>
    let makeCommand: (NavigationNode) -> NavigationCommand
}

extension CommandsGalleryItem {
    static func new(
        id: String = UUID().uuidString,
        viewModel: CommandsGalleryItemView.ViewModel,
        makeCommand: @escaping (NavigationNode) -> NavigationCommand
    ) -> CommandsGalleryItem {
        CommandsGalleryItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            makeCommand: makeCommand
        )
    }

    static func new(
        id: String = UUID().uuidString,
        viewModel: CommandsGalleryItemView.ViewModel,
        makeCommand: @escaping () -> NavigationCommand
    ) -> CommandsGalleryItem {
        CommandsGalleryItem(
            identifiableViewModel: IdentifiableViewModel(id: id, viewModel: viewModel),
            makeCommand: { _ in makeCommand() }
        )
    }
}

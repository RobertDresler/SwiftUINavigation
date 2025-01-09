import ExamplesNavigation
import Shared
import Foundation
import SwiftUINavigation

struct CommandsGalleryItem {
    let identifiableViewModel: IdentifiableViewModel<String, CommandsGalleryItemView.ViewModel>
    let makeCommand: () -> NavigationCommand
}

extension CommandsGalleryItem {
    static func new(
        viewModel: CommandsGalleryItemView.ViewModel,
        makeCommand: @escaping () -> NavigationCommand
    ) -> CommandsGalleryItem {
        CommandsGalleryItem(
            identifiableViewModel: IdentifiableViewModel(id: UUID().uuidString, viewModel: viewModel),
            makeCommand: makeCommand
        )
    }
}

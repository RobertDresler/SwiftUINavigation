import SwiftUINavigation

public struct StackReverseNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        stackMapCommand(for: model).execute(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        stackMapCommand(for: model).canExecute(on: model)
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    private func stackMapCommand(for model: any NavigationModel) -> NavigationCommand {
        .stackMap(
            { models in
                models.reversed()
            },
            animated: animated
        )
    }

}

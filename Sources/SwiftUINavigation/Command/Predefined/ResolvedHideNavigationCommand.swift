public struct ResolvedHideNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        resolvedCommand(on: model).execute(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        resolvedCommand(on: model).canExecute(on: model)
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    private func resolvedCommand(on model: any NavigationModel) -> NavigationCommand {
        if (model.parent as? any StackRootNavigationModel)?.path.first?.model === model {
            .dismiss(animated: animated)
        } else {
            .stackDropLast(animated: animated)
        }
    }

}

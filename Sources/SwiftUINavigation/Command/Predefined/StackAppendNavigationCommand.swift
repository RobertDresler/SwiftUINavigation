public struct StackAppendNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        stackMapCommand(for: model).execute(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        stackMapCommand(for: model).canExecute(on: model)
    }

    private let appendedModel: StackNavigationModel
    private let animated: Bool

    public init(appendedModel: StackNavigationModel, animated: Bool = true) {
        self.appendedModel = appendedModel
        self.animated = animated
    }

    public init(appendedModel: any NavigationModel, animated: Bool = true) {
        self.appendedModel = StackNavigationModel(model: appendedModel)
        self.animated = animated
    }

    private func stackMapCommand(for model: any NavigationModel) -> NavigationCommand {
        .stackMap(
            { models in
                models + [appendedModel]
            },
            animated: animated
        )
    }

}

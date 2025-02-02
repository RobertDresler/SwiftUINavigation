public struct StackSetRootNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        stackMapCommand(for: model).execute(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        stackMapCommand(for: model).canExecute(on: model)
    }

    private let rootModel: any NavigationModel
    private let clear: Bool
    private let animated: Bool

    public init(rootModel: any NavigationModel, clear: Bool, animated: Bool = true) {
        self.rootModel = rootModel
        self.clear = clear
        self.animated = animated
    }

    private func stackMapCommand(for model: any NavigationModel) -> NavigationCommand {
        .stackMap(
            { models in
                let rootModelWithStackTransition = StackNavigationModel(
                    destination: rootModel,
                    transition: nil
                )
                if clear || models.isEmpty {
                    return [rootModelWithStackTransition]
                } else {
                    var newModels = models
                    newModels.removeFirst()
                    return [rootModelWithStackTransition] + newModels
                }
            },
            animated: animated
        )
    }

}

public struct StackDropLastNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        stackMapCommand(for: model).execute(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        stackMapCommand(for: model).canExecute(on: model)
    }

    private let k: UInt
    private let animated: Bool

    public init(k: UInt = 1, animated: Bool = true) {
        self.k = k
        self.animated = animated
    }

    private func stackMapCommand(for model: any NavigationModel) -> NavigationCommand {
        .stackMap(
            { models in
                models.dropLast(min(Int(k), models.count - 1))
            },
            animated: animated
        )
    }

}

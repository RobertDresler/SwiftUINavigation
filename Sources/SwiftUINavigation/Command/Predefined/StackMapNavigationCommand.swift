public struct StackMapNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        mapStackModels(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        model.predecessorsIncludingSelf.contains(where: { $0 is any StackRootNavigationModel })
    }

    private let animated: Bool
    private let transform: ([StackNavigationModel]) -> [StackNavigationModel]

    public init(
        animated: Bool,
        transform: @escaping ([StackNavigationModel]) -> [StackNavigationModel]
    ) {
        self.animated = animated
        self.transform = transform
    }

    private func mapStackModels(on model: any NavigationModel) {
        guard let model = model as? any StackRootNavigationModel else {
            if let parent = model.parent {
                return mapStackModels(on: parent)
            } else {
                return
            }
        }
        setMappedModels(for: model)
    }

    private func setMappedModels(for model: any StackRootNavigationModel) {
        perform(
            animated: animated,
            action: {
                model.path = transform(model.path)
            }
        )
    }

}

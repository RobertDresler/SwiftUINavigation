public struct DismissJustFromPresentedNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        guard canExecute(on: model) else { return }
        if model.presentedModel != nil {
            perform(
                animated: animated,
                action: { model.presentedModel = nil }
            )
        } else if let parent = model.parent {
            execute(on: parent)
        }
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        model.predecessorsIncludingSelf.contains { predecessorIncludingSelf in
            guard let presentedModel = predecessorIncludingSelf.presentedModel else { return false }
            return model.predecessorsIncludingSelf.contains(where: { $0 === presentedModel.model })
        }
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

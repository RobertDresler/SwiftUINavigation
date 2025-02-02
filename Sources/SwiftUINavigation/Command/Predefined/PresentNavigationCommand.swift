public struct PresentNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        guard let presenterModel = presenterModel(for: model) else { return }
        executableCommand.execute(on: presenterModel)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        guard let presenterModel = presenterModel(for: model) else { return false }
        return executableCommand.canExecute(on: model)
    }

    private let presentedModel: any PresentedNavigationModel
    private let animated: Bool

    public init(presentedModel: any PresentedNavigationModel, animated: Bool = true) {
        self.presentedModel = presentedModel
        self.animated = animated
    }

    private var executableCommand: NavigationCommand {
        PresentOnGivenModelNavigationCommand(
            presentedModel: presentedModel,
            animated: animated
        )
    }

    /// If `sourceID` is not `nil`, `presentedModel` is presented on the `model` from `execude(_on:)` since we want to present from
    /// `presenterResolvedViewModifier(presentedModel:content:sourceID:)` on that source view
    private func presenterModel(for model: any NavigationModel) -> (any NavigationModel)? {
        presentedModel.sourceID == nil ? model.nearestModelWhichCanPresent : model
    }

}

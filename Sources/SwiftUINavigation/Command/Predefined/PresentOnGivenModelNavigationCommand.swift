public struct PresentOnGivenModelNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        perform(
            animated: animated,
            action: { model.presentedModel = presentedModel }
        )
    }

    private let presentedModel: any PresentedNavigationModel
    private let animated: Bool

    public init(presentedModel: any PresentedNavigationModel, animated: Bool = true) {
        self.presentedModel = presentedModel
        self.animated = {
            if let presentedModel = presentedModel as? FullScreenCoverPresentedNavigationModel,
            presentedModel.transition != nil {
                false
            } else {
                animated
            }
        }()
    }

}

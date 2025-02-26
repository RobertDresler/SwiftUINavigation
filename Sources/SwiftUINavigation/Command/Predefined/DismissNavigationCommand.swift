public struct DismissNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        guard let nearestModelWhichCanPresent = model.nearestModelWhichCanPresent else { return }
        perform(
            animated: animated,
            action: { nearestModelWhichCanPresent.sendEnvironmentTrigger(DismissNavigationEnvironmentTrigger()) }
        )
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        let nearestModelWhichCanPresent = model.nearestModelWhichCanPresent
        return nearestModelWhichCanPresent?.parent?.presentedModel?.model === nearestModelWhichCanPresent
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

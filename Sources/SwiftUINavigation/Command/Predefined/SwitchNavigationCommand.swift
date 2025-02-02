public struct SwitchNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        guard let state = model as? any SwitchedNavigationModel else { return }
        state.switchedModel = switchedModel
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        model is any SwitchedNavigationModel
    }

    private let switchedModel: any NavigationModel

    public init(switchedModel: any NavigationModel) {
        self.switchedModel = switchedModel
    }

}

public struct StackNavigationModel {

    public let model: any NavigationModel
    let transition: StackNavigationTransition?

    public init(model: any NavigationModel, transition: StackNavigationTransition? = nil) {
        self.model = model
        self.transition = transition
    }

}


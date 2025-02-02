public struct StackNavigationModel {

    public let destination: any NavigationModel
    let transition: StackNavigationTransition?

    public init(destination: any NavigationModel, transition: StackNavigationTransition? = nil) {
        self.destination = destination
        self.transition = transition
    }

}


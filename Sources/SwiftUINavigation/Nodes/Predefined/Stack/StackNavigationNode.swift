public struct StackNavigationNode {

    public let destination: any NavigationNode
    let transition: StackNavigationTransition?

    public init(destination: any NavigationNode, transition: StackNavigationTransition? = nil) {
        self.destination = destination
        self.transition = transition
    }

}


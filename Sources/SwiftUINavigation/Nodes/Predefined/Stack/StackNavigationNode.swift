public struct StackNavigationNode {

    public let destination: NavigationNode
    let transition: StackNavigationTransition?

    public init(destination: NavigationNode, transition: StackNavigationTransition? = nil) {
        self.destination = destination
        self.transition = transition
    }

}


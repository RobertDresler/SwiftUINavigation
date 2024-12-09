public struct StackNavigationNode {

    public let destination: NavigationNode
    let transition: StackNavigationTransition?

    public init(destination: NavigationNode, transition: StackNavigationTransition?) {
        self.destination = destination
        self.transition = transition
    }

}


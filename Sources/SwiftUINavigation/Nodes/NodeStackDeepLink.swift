public struct NavigationNodeWithStackTransition {

    public let destination: NavigationNode
    let transition: StackDeepLink.Transition?

    var toStackDeepLink: StackDeepLink? {
        StackDeepLink(nodeID: destination.id, transition: transition)
    }

    public init(destination: NavigationNode, transition: StackDeepLink.Transition?) {
        self.destination = destination
        self.transition = transition
    }

}


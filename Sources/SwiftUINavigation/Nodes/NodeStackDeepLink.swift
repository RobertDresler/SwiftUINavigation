public struct SwiftUINavigationNodeWithStackTransition {

    let destination: SwiftUINavigationNode
    let transition: StackDeepLink.Transition?

    var toStackDeepLink: StackDeepLink? {
        StackDeepLink(nodeID: destination.id, transition: transition)
    }

    public init(destination: SwiftUINavigationNode, transition: StackDeepLink.Transition?) {
        self.destination = destination
        self.transition = transition
    }

}


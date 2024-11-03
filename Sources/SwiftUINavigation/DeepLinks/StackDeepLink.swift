public struct StackDeepLink: Hashable {

    public enum Transition: Hashable {
        case zoom(sourceID: String)
    }

    let nodeID: String
    let transition: Transition?

    public init(nodeID: String, transition: Transition? = nil) {
        self.nodeID = nodeID
        self.transition = transition
    }

}

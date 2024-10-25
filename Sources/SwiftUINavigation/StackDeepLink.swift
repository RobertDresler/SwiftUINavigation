public struct StackDeepLink<Destination: Hashable>: Hashable {

    public enum Transition: Hashable {
        case zoom(sourceID: String)
    }

    let destination: Destination
    let transition: Transition?

    public init(destination: Destination, transition: Transition? = nil) {
        self.destination = destination
        self.transition = transition
    }

}

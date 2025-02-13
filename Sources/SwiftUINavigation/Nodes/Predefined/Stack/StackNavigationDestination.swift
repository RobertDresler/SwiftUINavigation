public struct StackNavigationDestination: Hashable {

    let modelID: String
    let transition: StackNavigationTransition?

    public func hash(into hasher: inout Hasher) {
        hasher.combine(modelID)
    }

    public static func == (lhs: StackNavigationDestination, rhs: StackNavigationDestination) -> Bool {
        lhs.modelID == rhs.modelID
    }

}

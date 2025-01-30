public struct EquatableNavigationNode: Equatable {

    public static func == (lhs: EquatableNavigationNode, rhs: EquatableNavigationNode) -> Bool {
        lhs.wrapped?.id == rhs.wrapped?.id
    }

    public weak var wrapped: (any NavigationNode)?

}

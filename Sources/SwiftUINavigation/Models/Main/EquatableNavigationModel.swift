public struct EquatableNavigationModel: Equatable {

    public static func == (lhs: EquatableNavigationModel, rhs: EquatableNavigationModel) -> Bool {
        lhs.wrapped?.id == rhs.wrapped?.id
    }

    public weak var wrapped: (any NavigationModel)?

}

public struct ActionableListInputData: Hashable {

    public enum ID {
        case home
        case modalsTraditional
        case modalsSpecial
        case stack
        case urlHandling
    }

    public let id: ID
    public let addPresentationDetents: Bool

    public init(id: ID, addPresentationDetents: Bool = false) {
        self.id = id
        self.addPresentationDetents = addPresentationDetents
    }

    public static var `default`: ActionableListInputData {
        ActionableListInputData(id: .home)
    }

}

public struct ActionableListInputData {

    public enum ID {
        case commands
        case modalsTraditional
        case modalsSpecial
        case stack
        case urlHandling
        case flows
        case architectures
    }

    public let id: ID
    public let addPresentationDetents: Bool

    public init(id: ID, addPresentationDetents: Bool = false) {
        self.id = id
        self.addPresentationDetents = addPresentationDetents
    }

    public static var `default`: ActionableListInputData {
        ActionableListInputData(id: .commands)
    }

}

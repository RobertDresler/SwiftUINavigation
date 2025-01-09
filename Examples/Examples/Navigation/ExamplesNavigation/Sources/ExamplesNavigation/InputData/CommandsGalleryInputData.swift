public struct CommandsGalleryInputData: Hashable {

    public enum ID {
        case home
        case modal
        case stack
    }

    public let id: ID
    public let addPresentationDetents: Bool

    public init(id: ID, addPresentationDetents: Bool = false) {
        self.id = id
        self.addPresentationDetents = addPresentationDetents
    }

    public static var `default`: CommandsGalleryInputData {
        CommandsGalleryInputData(id: .home)
    }

}

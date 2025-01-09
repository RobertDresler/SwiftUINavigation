public struct CommandsGalleryInputData: Hashable {

    public enum ID {
        case home
        case modal
    }

    public let id: ID

    public init(id: ID) {
        self.id = id
    }

    public static var `default`: CommandsGalleryInputData {
        CommandsGalleryInputData(id: .home)
    }

}

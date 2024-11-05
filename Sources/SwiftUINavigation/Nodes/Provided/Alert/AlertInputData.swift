public struct AlertInputData: Hashable {

    let title: String
    let message: String

    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }

}

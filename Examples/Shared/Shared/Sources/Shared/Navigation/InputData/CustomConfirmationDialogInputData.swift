public struct CustomConfirmationDialogInputData {

    public let title: String
    public let message: String
    public let confirmButtonTitle: String

    public init(title: String, message: String, confirmButtonTitle: String) {
        self.title = title
        self.message = message
        self.confirmButtonTitle = confirmButtonTitle
    }

}

public final class ConfirmationDialogNavigationNode: NavigationNode {

    let inputData: ConfirmationDialogInputData
    let sourceID: String?

    init(inputData: ConfirmationDialogInputData, sourceID: String?) {
        self.inputData = inputData
        self.sourceID = sourceID
    }

}

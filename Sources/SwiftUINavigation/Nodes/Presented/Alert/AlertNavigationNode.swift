public final class AlertNavigationNode: NavigationNode {

    let inputData: AlertInputData
    let sourceID: String?

    init(inputData: AlertInputData, sourceID: String?) {
        self.inputData = inputData
        self.sourceID = sourceID
    }

}


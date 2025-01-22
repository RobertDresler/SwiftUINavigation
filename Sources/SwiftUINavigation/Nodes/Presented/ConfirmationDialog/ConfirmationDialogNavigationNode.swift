import SwiftUI

@NavigationNode
final class ConfirmationDialogNavigationNode {

    var body: EmptyView {
        EmptyView()
    }

    let inputData: ConfirmationDialogInputData

    init(inputData: ConfirmationDialogInputData) {
        self.inputData = inputData
    }

}

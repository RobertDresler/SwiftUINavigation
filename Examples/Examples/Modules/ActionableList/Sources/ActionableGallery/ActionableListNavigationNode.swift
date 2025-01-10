import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ActionableListNavigationNode: NavigationNode {

    private let inputData: ActionableListInputData

    public init(inputData: ActionableListInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(ActionableListView(inputData: inputData))
    }

    func confirmLogout(sourceID: String) async -> Bool {
        await withCheckedContinuation { continuation in
            let inputData = ConfirmationDialogInputData(
                message: "Are you sure you want to log out? Don't worry, you can easily log in again afterwards!",
                actions: [
                    ConfirmationDialogInputData.Action(
                        id: "cancel",
                        title: "No, Keep Me Logged In",
                        role: .cancel,
                        handler: { continuation.resume(returning: false) }
                    ),
                    ConfirmationDialogInputData.Action(
                        id: "confirm",
                        title: "Yes, Log Me Out!",
                        role: .destructive,
                        handler: { continuation.resume(returning: true) }
                    )
                ]
            )
            executeCommand(
                PresentNavigationCommand(
                    presentedNode: ConfirmationDialogPresentedNavigationNode(inputData: inputData, sourceID: sourceID)
                )
            )
        }
    }

}


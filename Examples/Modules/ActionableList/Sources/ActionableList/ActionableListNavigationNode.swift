import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import CustomConfirmationDialog

@NavigationNode
public final class ActionableListNavigationNode {

    private let inputData: ActionableListInputData

    public init(inputData: ActionableListInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ActionableListView(inputData: inputData)
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
            execute(.present(.confirmationDialog(inputData, sourceID: sourceID)))
        }
    }

    func openNotificationSettings() {
        guard let url = URL(string: UIApplication.openNotificationSettingsURLString) else { return }
        execute(.openURL(url))
    }

    func confirmLogoutWithCustomConfirmationDialog() async -> Bool {
        await withCheckedContinuation { continuation in
            let node = createLogoutCustomConfirmationDialogNavigationNode()
            var didConfirm = false
            node.addMessageListener({ message in
                if message is CustomConfirmationDialogConfirmationNavigationMessage {
                    didConfirm = true
                } else if message is RemovalNavigationMessage {
                    continuation.resume(returning: didConfirm)
                }
            })
            execute(.present(.sheet(.stacked(node))))
        }
    }

    private func createLogoutCustomConfirmationDialogNavigationNode() -> CustomConfirmationDialogNavigationNode {
        let inputData = CustomConfirmationDialogInputData(
            title: "Confirm Logout",
            message: "Are you sure you want to log out? You can easily log in again anytime.",
            confirmButtonTitle: "Log Out"
        )
        return CustomConfirmationDialogNavigationNode(inputData: inputData)
    }

    var canDismiss: Bool {
        canExecute(DismissJustFromPresentedNavigationCommand())
    }

    func dismiss() {
        execute(.dismiss())
    }

}


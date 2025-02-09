import SwiftUINavigation
import SwiftUI
import CustomConfirmationDialog
import Shared

@NavigationModel
public final class ActionableListNavigationModel {

    private lazy var viewModel = ActionableListViewModel(
        inputData: inputData,
        navigationModel: self,
        deepLinkForwarderService: deepLinkForwarderService,
        notificationsService: notificationsService,
        flagsRepository: flagsRepository
    )
    private let inputData: ActionableListInputData
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let notificationsService: NotificationsService
    private let flagsRepository: FlagsRepository

    public init(
        inputData: ActionableListInputData,
        deepLinkForwarderService: DeepLinkForwarderService,
        notificationsService: NotificationsService,
        flagsRepository: FlagsRepository
    ) {
        self.inputData = inputData
        self.deepLinkForwarderService = deepLinkForwarderService
        self.notificationsService = notificationsService
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        ActionableListView(viewModel: viewModel)
    }

    // MARK: Custom

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

    func presentLogoutWithCustomConfirmationDialog() {
        let model = createLogoutCustomConfirmationDialogNavigationModel()
            .onMessageReceived { [weak self] message in
                switch message {
                case _ as CustomConfirmationDialogConfirmationNavigationMessage:
                    self?.viewModel.logout()
                default:
                    break
                }
            }
        execute(.present(.sheet(.stacked(model))))
    }

    private func createLogoutCustomConfirmationDialogNavigationModel() -> CustomConfirmationDialogNavigationModel {
        let inputData = CustomConfirmationDialogInputData(
            title: "Confirm Logout",
            message: "Are you sure you want to log out? You can easily log in again anytime.",
            confirmButtonTitle: "Log Out"
        )
        return CustomConfirmationDialogNavigationModel(inputData: inputData)
    }

    var canDismiss: Bool {
        canExecute(DismissJustFromPresentedNavigationCommand())
    }

    func dismiss() {
        execute(.dismiss())
    }

}


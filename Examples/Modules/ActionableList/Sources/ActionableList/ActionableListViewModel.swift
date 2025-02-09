import SwiftUINavigation
import SwiftUI
import CustomConfirmationDialog
import Shared

/// This module is generic module which shows list of items based on `id` from `ActionableListInputData`. To resolve the data,
/// it uses `ActionableListDataFactory`. When certain item gets tapped, `handleAction(for:)` gets called. It either executes
/// `NavigationCommand`, handles `ExamplesAppNavigationDeepLink` or performs custom action. To see data factory for each `id`, navigate to
/// `Data/Factories/...` folder.
@MainActor final class ActionableListViewModel: ObservableObject {

    let title: String
    let subtitle: String?
    let items: [ActionableListItem]
    let inputData: ActionableListInputData
    private unowned let navigationModel: ActionableListNavigationModel
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let notificationsService: NotificationsService
    private let flagsRepository: FlagsRepository

    init(
        inputData: ActionableListInputData,
        navigationModel: ActionableListNavigationModel,
        deepLinkForwarderService: DeepLinkForwarderService,
        notificationsService: NotificationsService,
        flagsRepository: FlagsRepository
    ) {
        self.inputData = inputData
        self.navigationModel = navigationModel
        self.deepLinkForwarderService = deepLinkForwarderService
        self.notificationsService = notificationsService
        self.flagsRepository = flagsRepository
        let factory = Self.makeDataFactory(
            inputData: inputData,
            deepLinkForwarderService: deepLinkForwarderService,
            notificationsService: notificationsService,
            flagsRepository: flagsRepository
        )
        self.title = factory.makeTitle()
        self.subtitle = factory.makeSubtitle()
        self.items = factory.makeItems()
    }

    func handleAction(for itemID: String) {
        guard let action = items.first(where: { $0.identifiableViewModel.id == itemID })?.action else { return }
        switch action {
        case .command(let makeCommand):
            navigationModel.execute(makeCommand(navigationModel))
        case .deepLink(let deepLink):
            deepLinkForwarderService.forwardDeepLink(deepLink)
        case .custom(let customAction):
            switch customAction {
            case .logout(let sourceID):
                handleLogoutAction(sourceID: sourceID)
            case .sendNotification:
                handleSendNotificationAction()
            case .logoutWithCustomConfirmationDialog:
                handleLogoutWithCustomConfirmationDialog()
            case .logoutWithConfirmation:
                logout()
            case .printDebugGraph:
                printDebugGraph()
            case .lockApp:
                lockApp()
            case .openWaitingWindow:
                openWaitingWindow()
            }
        }
    }

}

// MARK: Custom Actions
/// These actions don't require to execute command or handle deep link so they are hard coded in the ViewModel
extension ActionableListViewModel {
    func logout() {
        flagsRepository.isUserLogged = false
    }

    private func handleLogoutAction(sourceID: String) {
        Task {
            guard await navigationModel.confirmLogout(sourceID: sourceID) else { return }
            logout()
        }
    }

    private func handleSendNotificationAction() {
        Task { @MainActor in
            switch await notificationsService.getAuthorizationStatus() {
            case .notDetermined:
                if await notificationsService.requestAuthorization() {
                    await sendNotification()
                } else {
                    openNotificationSettings()
                }
            case .denied, .provisional, .ephemeral:
                openNotificationSettings()
            case .authorized:
                await sendNotification()
            @unknown default:
                openNotificationSettings()
            }
        }
    }

    private func openNotificationSettings() {
        navigationModel.openNotificationSettings()
    }

    private func sendNotification() async {
        do {
            try await notificationsService.sendNotification(
                title: "Ready for Premium?",
                body: "Tap here to check out the Subscription screen. Who knows, maybe it's your lucky day for an upgrade!",
                userInfo: deepLinkForwarderService.userInfo(
                    for: ExamplesAppNavigationDeepLink(destination: .subscription(SubscriptionInputData()))
                )
            )
        } catch {
            print(error)
        }
    }

    private func handleLogoutWithCustomConfirmationDialog() {
        navigationModel.presentLogoutWithCustomConfirmationDialog()
    }

    private func printDebugGraph() {
        navigationModel.printDebugGraph()
    }

    private func lockApp() {
        flagsRepository.isAppLocked = true
    }

    private func openWaitingWindow() {
        flagsRepository.isWaitingWindowOpen = true
    }
}

// MARK: Data Factory

private extension ActionableListViewModel {
    static func makeDataFactory(
        inputData: ActionableListInputData,
        deepLinkForwarderService: DeepLinkForwarderService,
        notificationsService: NotificationsService,
        flagsRepository: FlagsRepository
    ) -> ActionableListDataFactory {
        switch inputData.id {
        case .commands:
            CommandsActionableListDataFactory(
                deepLinkForwarderService: deepLinkForwarderService,
                notificationsService: notificationsService,
                flagsRepository: flagsRepository
            )
        case .modalsTraditional:
            ModalsTraditionalActionableListDataFactory(
                deepLinkForwarderService: deepLinkForwarderService,
                notificationsService: notificationsService,
                flagsRepository: flagsRepository
            )
        case .modalsSpecial:
            ModalsSpecialActionableListDataFactory()
        case .stack:
            StackActionableListDataFactory(
                deepLinkForwarderService: deepLinkForwarderService,
                notificationsService: notificationsService,
                flagsRepository: flagsRepository
            )
        case .urlHandling:
            URLHandlingActionableListDataFactory()
        case .flows:
            FlowsActionableListDataFactory(
                deepLinkForwarderService: deepLinkForwarderService,
                notificationsService: notificationsService,
                flagsRepository: flagsRepository
            )
        }
    }
}

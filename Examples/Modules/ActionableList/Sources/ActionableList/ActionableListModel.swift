import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import CustomConfirmationDialog
import DeepLinkForwarderService
import NotificationsService
import FlagsRepository

@MainActor final class ActionableListModel: ObservableObject {

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
        let factory: ActionableListDataFactory = {
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
        }()
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
                    for: ExamplesNavigationDeepLink(destination: .subscription(SubscriptionInputData()))
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


import SwiftUI
import ExamplesNavigation
import SwiftUINavigation
import Shared
import FlagsRepository
import NotificationsService
import DeepLinkForwarderService

struct ActionableListView: View {

    @EnvironmentNavigationNode private var navigationNode: ActionableListNavigationNode
    @Environment(\.stackNavigationNamespace) private var wrappedNavigationStackNodeNamespace
    @EnvironmentObject private var flagsRepository: FlagsRepository
    @EnvironmentObject private var notificationsService: NotificationsService
    @EnvironmentObject private var deepLinkForwarderService: DeepLinkForwarderService

    var inputData: ActionableListInputData
    let title: String
    let subtitle: String?
    let items: [ActionableListItem]

    init(inputData: ActionableListInputData) {
        self.inputData = inputData
        let factory: ActionableListDataFactory = {
            switch inputData.id {
            case .commands:
                CommandsActionableListDataFactory()
            case .modalsTraditional:
                ModalsTraditionalActionableListDataFactory()
            case .modalsSpecial:
                ModalsSpecialActionableListDataFactory()
            case .stack:
                StackActionableListDataFactory()
            case .urlHandling:
                URLHandlingActionableListDataFactory()
            case .flows:
                FlowsActionableListDataFactory()
            case .architectures:
                ArchitecturesActionableListDataFactory()
            }
        }()
        self.title = factory.makeTitle()
        self.subtitle = factory.makeSubtitle()
        self.items = factory.makeItems()
    }

    var body: some View {
        scrollView
            .navigationTitle(title)
            .toolbar {
                if navigationNode.canDismiss {
                    ToolbarItem(placement: .topBarTrailing) {
                        dismissButton
                    }
                }
            }
            .presentationDetents(inputData.addPresentationDetents ? [.medium, .large] : [])
    }

    private var dismissButton: some View {
        DismissButton(action: { navigationNode.dismiss() })
    }

    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let subtitle {
                    self.subtitle(for: subtitle)
                }
                itemsView
            }
                .padding()
        }.background(SharedColor.backgroundGray)
    }

    private func subtitle(for subtitle: String) -> some View {
        Text(subtitle)
            .font(.system(size: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }

    private var itemsView: some View {
        VStack(spacing: 8) {
            ForEach(items, id: \.identifiableViewModel.id) { item in
                if #available(iOS 18.0, *), let wrappedNavigationStackNodeNamespace {
                    configuredItemViewWithPresentingNavigationSource(for: item)
                        .matchedTransitionSource(
                            id: item.identifiableViewModel.id,
                            in: wrappedNavigationStackNodeNamespace
                        )
                } else {
                    configuredItemViewWithPresentingNavigationSource(for: item)
                }
            }
        }
    }

    private func configuredItemViewWithPresentingNavigationSource(
        for item: ActionableListItem
    ) -> some View {
        Group {
            if let presentingNavigationSourceID = item.presentingNavigationSourceID {
                configuredItemView(for: item.identifiableViewModel)
                    .presentingNavigationSource(id: presentingNavigationSourceID)
            } else {
                configuredItemView(for: item.identifiableViewModel)
            }
        }
    }

    private func configuredItemView(
        for item: IdentifiableViewModel<String, ActionableListItemView.ViewModel>
    ) -> some View {
        ActionableListItemView(
            viewModel: item.viewModel,
            action: { handleAction(for: item.id) }
        )
    }

    // MARK: Actions

    private func handleAction(for itemID: String) {
        guard let action = items.first(where: { $0.identifiableViewModel.id == itemID })?.action else { return }
        switch action {
        case .command(let makeCommand):
            navigationNode.execute(makeCommand(navigationNode))
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

    private func handleLogoutAction(sourceID: String) {
        Task {
            guard await navigationNode.confirmLogout(sourceID: sourceID) else { return }
            logout()
        }
    }

    private func logout() {
        flagsRepository.isUserLogged = false
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
        navigationNode.openNotificationSettings()
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
        Task {
            guard await navigationNode.confirmLogoutWithCustomConfirmationDialog() else { return }
            logout()
        }
    }

    private func printDebugGraph() {
        navigationNode.printDebugGraph()
    }

    private func lockApp() {
        flagsRepository.isAppLocked = true
    }

    private func openWaitingWindow() {
        flagsRepository.isWaitingWindowOpen = true
    }

}

#Preview {
    ActionableListNavigationNode(inputData: .default).body
}

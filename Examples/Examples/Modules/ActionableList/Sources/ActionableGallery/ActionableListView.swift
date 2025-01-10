import SwiftUI
import ExamplesNavigation
import SwiftUINavigation
import Shared
import UserRepository
import NotificationsService
import DeepLinkForwarderService

struct ActionableListView: View {

    @EnvironmentNavigationNode private var navigationNode: ActionableListNavigationNode
    @Environment(\.stackNavigationNamespace) private var wrappedNavigationStackNodeNamespace
    @EnvironmentObject private var userRepository: UserRepository
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
                if navigationNode.canExecuteCommand(DismissJustFromPresentedNavigationCommand()) {
                    ToolbarItem(placement: .topBarTrailing) {
                        dismissButton
                    }
                }
            }
            .presentationDetents(inputData.addPresentationDetents ? [.medium, .large] : [])
    }

    private var dismissButton: some View {
        Button(action: { navigationNode.executeCommand(DismissNavigationCommand()) }) {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .tint(SharedColor.grayscaleSecondary)
                .font(.system(size: 24))
        }
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
            navigationNode.executeCommand(makeCommand(navigationNode))
        case .custom(let customAction):
            switch customAction {
            case .logout(let sourceID):
                handleLogoutAction(sourceID: sourceID)
            case .sendNotification:
                handleSendNotificationAction()
            }
        }
    }

    private func handleLogoutAction(sourceID: String) {
        Task {
            guard await navigationNode.confirmLogout(sourceID: sourceID) else { return }
            userRepository.isUserLogged = false
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

}

#Preview {
    ActionableListNavigationNode(inputData: .default).view
}

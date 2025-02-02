import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Combine
import Start
import MainTabs
import DeepLinkForwarderService
import OnboardingService
import LockedApp
import ExamplesNavigationDeepLinkHandler
import NotificationsService

@SwitchedNavigationModel
public final class AppNavigationModel {

    public var switchedModel: (any NavigationModel)?

    private let flagsRepository: FlagsRepository
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let onboardingService: OnboardingService
    private let notificationsService: NotificationsService

    public init(
        flagsRepository: FlagsRepository,
        deepLinkForwarderService: DeepLinkForwarderService,
        onboardingService: OnboardingService,
        notificationsService: NotificationsService
    ) {
        self.flagsRepository = flagsRepository
        self.deepLinkForwarderService = deepLinkForwarderService
        self.onboardingService = onboardingService
        self.notificationsService = notificationsService
    }

    public func body(for content: SwitchedNavigationModelView<AppNavigationModel>) -> some View {
        content
            .onReceive(flagsRepository.$isUserLogged) { [weak self] in self?.switchModel(isUserLogged: $0) }
            .onReceive(flagsRepository.$isAppLocked) { [weak self] in self?.setLockedAppWindow(isAppLocked: $0) }
            .onReceive(flagsRepository.$isWaitingWindowOpen) { [weak self] in self?.handleIsWaitingWindowOpen($0) }
            .onReceive(deepLinkForwarderService.deepLinkPublisher) { [weak self] in self?.handleDeepLink($0) }
    }
    
    private func switchModel(isUserLogged: Bool) {
        execute(
            .switchModel(
                isUserLogged
                    ? MainTabsNavigationModel(
                        inputData: MainTabsInputData(
                            initialTab: .commands
                        ),
                        deepLinkForwarderService: deepLinkForwarderService,
                        notificationsService: notificationsService,
                        flagsRepository: flagsRepository
                    )
                    : .stacked(StartNavigationModel(flagsRepository: flagsRepository, onboardingService: onboardingService))
            )
        )
    }

    private func handleDeepLink(_ deepLink: ExamplesNavigationDeepLink) {
        execute(
            ExamplesNavigationDeepLinkHandler(flagsRepository: flagsRepository)
                .handleDeepLinkCommand(deepLink)
        )
    }

    private func setLockedAppWindow(isAppLocked: Bool) {
        if isAppLocked {
            execute(
                .present(
                    .fullScreenCover(.stacked(LockedAppNavigationModel(flagsRepository: flagsRepository))),
                    animated: false
                )
            )
        } else {
            execute(.dismiss(animated: false))
        }
    }

    private func handleIsWaitingWindowOpen(_ isOpen: Bool) {
        if isOpen {
            execute(.openWindow(id: WindowID.waiting.rawValue))
        } else {
            if #available(iOS 17, *) {
                execute(.dismissWindow(id: WindowID.waiting.rawValue))
            } else {
                /// On iOS 16 you have to dismiss window from window itself, see `WaitingNavigationModel`
            }
        }
    }

}

import SwiftUI
import SwiftUINavigation
import Combine
import Start
import MainTabs
import LockedApp
import Shared

@SwitchedNavigationModel
public final class AppNavigationModel {

    public var switchedModel: (any NavigationModel)?

    private let flagsRepository: FlagsRepository
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let onboardingService: OnboardingService
    private let notificationsService: NotificationsService
    private let handleDeepLinkNavigationCommandFactory: HandleDeepLinkNavigationCommandFactory

    public init(
        flagsRepository: FlagsRepository,
        deepLinkForwarderService: DeepLinkForwarderService,
        onboardingService: OnboardingService,
        notificationsService: NotificationsService,
        handleDeepLinkNavigationCommandFactory: HandleDeepLinkNavigationCommandFactory
    ) {
        self.flagsRepository = flagsRepository
        self.deepLinkForwarderService = deepLinkForwarderService
        self.onboardingService = onboardingService
        self.notificationsService = notificationsService
        self.handleDeepLinkNavigationCommandFactory = handleDeepLinkNavigationCommandFactory
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

    private func handleDeepLink(_ deepLink: ExamplesAppNavigationDeepLink) {
        execute(handleDeepLinkNavigationCommandFactory.makeCommand(for: deepLink))
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

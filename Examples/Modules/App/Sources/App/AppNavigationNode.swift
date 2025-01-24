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

@SwitchedNavigationNode
public final class AppNavigationNode {

    private let flagsRepository: FlagsRepository
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let onboardingService: OnboardingService
    private var cancellables = Set<AnyCancellable>()

    public init(
        flagsRepository: FlagsRepository,
        deepLinkForwarderService: DeepLinkForwarderService,
        onboardingService: OnboardingService
    ) {
        self.flagsRepository = flagsRepository
        self.deepLinkForwarderService = deepLinkForwarderService
        self.onboardingService = onboardingService
        bind()
    }

    private var notLoggedNode: any NavigationNode {
        .stacked(StartNavigationNode(inputData: StartInputData(), onboardingService: onboardingService))
    }

    private var loggedNode: any NavigationNode {
        MainTabsNavigationNode(
            inputData: MainTabsInputData(
                initialTab: .commands
            )
        )
    }

    // MARK: Actions

    private func bind() {
        flagsRepository.$isUserLogged
            .sink { [weak self] in self?.setNode(isUserLogged: $0) }
            .store(in: &cancellables)

        flagsRepository.$isAppLocked
            .sink { [weak self] in self?.setLockedAppWindow(isAppLocked: $0) }
            .store(in: &cancellables)

        flagsRepository.$isWaitingWindowOpen
            .sink { [weak self] in self?.handleIsWaitingWindowOpen($0) }
            .store(in: &cancellables)

        deepLinkForwarderService.deepLinkPublisher
            .sink { [weak self] in self?.handleDeepLink($0) }
            .store(in: &cancellables)
    }

    private func setNode(isUserLogged: Bool) {
        let switchedNode = isUserLogged ? loggedNode : notLoggedNode
        execute(.switchNode(switchedNode))
    }

    private func handleDeepLink(_ deepLink: NavigationDeepLink) {
        execute(.handleDeepLink(deepLink))
    }

    private func setLockedAppWindow(isAppLocked: Bool) {
        if isAppLocked {
            execute(
                .present(
                    .fullScreenCover(.stacked(LockedAppNavigationNode(inputData: LockedAppInputData()))),
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
                /// On iOS 16 you have to dismiss window from window itself, see `WaitingNavigationNode`
            }
        }
    }

}

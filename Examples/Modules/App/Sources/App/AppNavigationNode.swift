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

@SwitchedNavigationNode
public final class AppNavigationNode {

    public var switchedNode: (any NavigationNode)?
    private let flagsRepository: FlagsRepository
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let onboardingService: OnboardingService

    public init(
        flagsRepository: FlagsRepository,
        deepLinkForwarderService: DeepLinkForwarderService,
        onboardingService: OnboardingService
    ) {
        self.flagsRepository = flagsRepository
        self.deepLinkForwarderService = deepLinkForwarderService
        self.onboardingService = onboardingService
    }

    public func body(for content: SwitchedNavigationNodeView<AppNavigationNode>) -> some View {
        content
            .onReceive(flagsRepository.$isUserLogged) { [weak self] in self?.switchNode(isUserLogged: $0) }
            .onReceive(flagsRepository.$isAppLocked) { [weak self] in self?.setLockedAppWindow(isAppLocked: $0) }
            .onReceive(flagsRepository.$isWaitingWindowOpen) { [weak self] in self?.handleIsWaitingWindowOpen($0) }
            .onReceive(deepLinkForwarderService.deepLinkPublisher) { [weak self] in self?.handleDeepLink($0) }
    }
    
    private func switchNode(isUserLogged: Bool) {
        execute(
            .switchNode(
                isUserLogged
                    ? MainTabsNavigationNode(
                        inputData: MainTabsInputData(
                            initialTab: .commands
                        )
                    )
                    : .stacked(StartNavigationNode(inputData: StartInputData(), onboardingService: onboardingService))
            )
        )
    }

    private func handleDeepLink(_ deepLink: ExamplesNavigationDeepLink) {
        ExamplesNavigationDeepLinkHandler(flagsRepository: flagsRepository)
            .handleDeepLink(deepLink, on: self)
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

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

public final class AppNavigationNode: SwitchedNavigationNode {

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
        super.init()
        bind()
    }

    public override var view: AnyView {
        AnyView(
            super.view
                .onShake { [weak self] in self?.printDebugGraph() }
        )
    }

    private var notLoggedNode: NavigationNode {
        StackRootNavigationNode(
            stackNodes: [
                StartNavigationNode(inputData: StartInputData(), onboardingService: onboardingService)
            ]
        )
    }

    private var loggedNode: NavigationNode {
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
        executeCommand(SwitchNavigationCommand(switchedNode: switchedNode))
    }

    private func handleDeepLink(_ deepLink: NavigationDeepLink) {
        executeCommand(DefaultHandleDeepLinkNavigationCommand(deepLink: deepLink))
    }

    private func setLockedAppWindow(isAppLocked: Bool) {
        if isAppLocked {
            executeCommand(
                PresentNavigationCommand(
                    presentedNode: FullScreenCoverPresentedNavigationNode.stacked(
                        node: LockedAppNavigationNode(inputData: LockedAppInputData())
                    ),
                    animated: false
                )
            )
        } else {
            executeCommand(DismissNavigationCommand(animated: false))
        }
    }

    private func handleIsWaitingWindowOpen(_ isOpen: Bool) {
        if isOpen {
            executeCommand(OpenWindowNavigationCommand(id: WindowID.waiting.rawValue))
        } else {
            if #available(iOS 17, *) {
                executeCommand(DismissWindowNavigationCommand(id: WindowID.waiting.rawValue))
            } else {
                /// On iOS 16 you have to dismiss window from window itself, see `WaitingNavigationNode`
            }
        }
    }

}

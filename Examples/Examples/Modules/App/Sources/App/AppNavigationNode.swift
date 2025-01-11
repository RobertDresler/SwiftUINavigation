import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository
import Combine
import Start
import MainTabs
import DeepLinkForwarderService
import OnboardingService

public final class AppNavigationNode: SwitchedNavigationNode {

    private let userRepository: UserRepository
    private let deepLinkForwarderService: DeepLinkForwarderService
    private let onboardingService: OnboardingService
    private var cancellables = Set<AnyCancellable>()

    public init(
        userRepository: UserRepository,
        deepLinkForwarderService: DeepLinkForwarderService,
        onboardingService: OnboardingService
    ) {
        self.userRepository = userRepository
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
        userRepository.$isUserLogged
            .sink { [weak self] in self?.setNode(isUserLogged: $0) }
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

}

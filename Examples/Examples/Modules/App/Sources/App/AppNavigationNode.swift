import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository
import Combine
import Start
import MainTabs

public final class AppNavigationNode: SwitchedNavigationNode {

    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()

    // TODO: -RD- maybe make root node which requires handler?
    public init(userRepository: UserRepository, defaultDeepLinkHandler: NavigationDeepLinkHandler) {
        self.userRepository = userRepository
        super.init(defaultDeepLinkHandler: defaultDeepLinkHandler)
        bind()
    }

    public override var view: AnyView {
        AnyView(
            super.view
                .onShake { [weak self] in self?.printDebugGraph() }
        )
    }

    private func bind() {
        userRepository.$isUserLogged
            .sink { [weak self] in self?.setDeepLink(isUserLogged: $0) }
            .store(in: &cancellables)
    }

    private func setDeepLink(isUserLogged: Bool) {
        let switchedNode = isUserLogged ? loggedNode : notLoggedNode
        executeCommand(SwitchNavigationCommand(switchedNode: switchedNode))
    }

    private var notLoggedNode: NavigationNode {
        StartNavigationNode(inputData: StartInputData())
    }

    private var loggedNode: NavigationNode {
        MainTabsNavigationNode(
            inputData: MainTabsInputData(
                initialTab: .commands
            )
        )
    }

}

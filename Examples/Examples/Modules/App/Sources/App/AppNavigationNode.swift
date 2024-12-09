import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository
import Combine
import Start
import ModuleA
import Settings

public final class AppNavigationNode: SwitchedNavigationNode {

    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()

    // TODO: -RD- maybe make root node which requires handler?
    public init(userRepository: UserRepository, defaultDeepLinkHandler: NavigationDeepLinkHandler) {
        self.userRepository = userRepository
        super.init(defaultDeepLinkHandler: defaultDeepLinkHandler)
        bind()
    }

    @MainActor
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
        let homeTab = DefaultTabNode(
            image: Image(systemName: "house.fill"),
            title: "Home",
            navigationNode: StackRootNavigationNode(
                stackNodes: [
                    StackNavigationNode(
                        destination: ModuleANavigationNode(
                            inputData: ModuleAInputData()
                        ),
                        transition: nil
                    )
                ]
            )
        )
        let settingsTab = DefaultTabNode(
            image: Image(systemName: "gearshape.fill"),
            title: "Settings",
            navigationNode: StackRootNavigationNode(
                stackNodes: [
                    StackNavigationNode(
                        destination: SettingsNavigationNode(
                            inputData: SettingsInputData()
                        ),
                        transition: nil
                    )
                ]
            )
        )
        return TabsRootNavigationNode(
            selectedTabNode: homeTab,
            tabsNodes: [
                homeTab,
                settingsTab
            ]
        )
    }

}

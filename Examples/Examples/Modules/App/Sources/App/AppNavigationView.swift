import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository
import Combine
import Start
import ModuleA

public final class AppNavigationNode: SwiftUINavigationNode {

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
        AnyView(SwiftUINavigationSwitchedNodeResolvedView())
    }

    private func bind() {
        userRepository.$isUserLogged
            .sink { [weak self] in self?.setDeepLink(isUserLogged: $0) }
            .store(in: &cancellables)
    }

    private func setDeepLink(isUserLogged: Bool) {
        let switchedNode = isUserLogged ? loggedNode : notLoggedNode
        executeCommand(.switchNode(switchedNode))
    }

    private var notLoggedNode: SwiftUINavigationNode {
        StartNavigationNode(inputData: StartInputData())
    }

    private var loggedNode: SwiftUINavigationNode {
        SwiftUINavigationStackRootNode(
            stackNodes: [
                SwiftUINavigationNodeWithStackTransition(
                    destination: ModuleANavigationNode(
                        inputData: ModuleAInputData()
                    ),
                    transition: nil
                )
            ]
        )
    }

}

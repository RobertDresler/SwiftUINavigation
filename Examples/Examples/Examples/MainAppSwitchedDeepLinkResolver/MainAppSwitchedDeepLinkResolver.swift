import SwiftUINavigation
import Combine
import UserRepository
import ExamplesNavigation

final class MainAppSwitchedDeepLinkResolver: SwiftUINavigationSwitchedDeepLinkResolver {

    let switchedDeepLink = CurrentValueSubject<ExamplesNavigationDeepLink?, Never>(nil)

    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
        bind()
    }

    private func bind() {
        userRepository.$isUserLogged
            .map { isUserLogged in
                isUserLogged
                    ? ExamplesNavigationDeepLink(destination: .logged(ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData()))))
                    : ExamplesNavigationDeepLink(destination: .notLogged(ExamplesNavigationDeepLink(destination: .start(StartInputData()))))
            }
            .subscribe(switchedDeepLink)
            .store(in: &cancellables)
    }

}

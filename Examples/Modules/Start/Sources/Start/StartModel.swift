import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@MainActor final class StartModel: ObservableObject {

    private unowned let navigationModel: StartNavigationModel
    private let flagsRepository: FlagsRepository

    init(navigationModel: StartNavigationModel, flagsRepository: FlagsRepository) {
        self.navigationModel = navigationModel
        self.flagsRepository = flagsRepository
    }

    func createAccount() {
        navigationModel.startOnboarding()
    }

    func login() {
        flagsRepository.isUserLogged = true
    }

}


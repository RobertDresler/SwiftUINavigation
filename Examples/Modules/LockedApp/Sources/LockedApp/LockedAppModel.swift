import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@MainActor final class LockedAppModel: ObservableObject {

    private unowned let navigationModel: LockedAppNavigationModel
    private let flagsRepository: FlagsRepository

    init(navigationModel: LockedAppNavigationModel, flagsRepository: FlagsRepository) {
        self.navigationModel = navigationModel
        self.flagsRepository = flagsRepository
    }

    func unlock() {
        flagsRepository.isAppLocked = false
    }

}


import SwiftUINavigation
import SwiftUI
import Shared

@MainActor final class LockedAppViewModel: ObservableObject {

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


import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@MainActor final class SubscriptionFreemiumModel: ObservableObject {

    private unowned let navigationModel: SubscriptionFreemiumNavigationModel
    private let flagsRepository: FlagsRepository

    init(navigationModel: SubscriptionFreemiumNavigationModel, flagsRepository: FlagsRepository) {
        self.navigationModel = navigationModel
        self.flagsRepository = flagsRepository
    }

    func subscribe() {
        flagsRepository.isUserPremium = true
    }

}


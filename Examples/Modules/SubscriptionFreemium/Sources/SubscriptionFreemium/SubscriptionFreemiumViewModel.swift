import SwiftUINavigation
import SwiftUI
import Shared

@MainActor final class SubscriptionFreemiumViewModel: ObservableObject {

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


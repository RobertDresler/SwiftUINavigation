import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@MainActor final class SubscriptionPremiumModel: ObservableObject {

    private unowned let navigationModel: SubscriptionPremiumNavigationModel
    private let flagsRepository: FlagsRepository

    init(navigationModel: SubscriptionPremiumNavigationModel, flagsRepository: FlagsRepository) {
        self.navigationModel = navigationModel
        self.flagsRepository = flagsRepository
    }

    func buyMeCoffee() {
        navigationModel.buyMeCoffee()
    }

    func unsubscribe() {
        flagsRepository.isUserPremium = false
    }

}


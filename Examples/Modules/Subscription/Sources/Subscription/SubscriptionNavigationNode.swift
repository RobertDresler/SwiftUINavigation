import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Combine
import SubscriptionPremium
import SubscriptionFreemium

@SwitchedNavigationNode
public final class SubscriptionNavigationNode {

    private let inputData: SubscriptionInputData
    private let flagsRepository: FlagsRepository
    private var cancellables = Set<AnyCancellable>()

    public init(inputData: SubscriptionInputData, flagsRepository: FlagsRepository) {
        self.inputData = inputData
        self.flagsRepository = flagsRepository
        bind()
    }

    private func bind() {
        flagsRepository.$isUserPremium
            .sink { [weak self] in self?.setNode(isUserPremium: $0) }
            .store(in: &cancellables)
    }

    private func setNode(isUserPremium: Bool) {
        let switchedNode = isUserPremium ? premiumNode : freemiumNode
        executeCommand(SwitchNavigationCommand(switchedNode: switchedNode))
    }

    private var premiumNode: any NavigationNode {
        SubscriptionPremiumNavigationNode(inputData: SubscriptionPremiumInputData())
    }

    private var freemiumNode: any NavigationNode {
        SubscriptionFreemiumNavigationNode(inputData: SubscriptionFreemiumInputData())
    }

}

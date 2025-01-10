import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository
import Combine
import SubscriptionPremium
import SubscriptionFreemium

public final class SubscriptionNavigationNode: SwitchedNavigationNode {

    private let inputData: SubscriptionInputData
    private let userRepository: UserRepository
    private var cancellables = Set<AnyCancellable>()

    public init(inputData: SubscriptionInputData, userRepository: UserRepository) {
        self.inputData = inputData
        self.userRepository = userRepository
        super.init()
        bind()
    }

    private func bind() {
        userRepository.$isUserPremium
            .sink { [weak self] in self?.setNode(isUserPremium: $0) }
            .store(in: &cancellables)
    }

    private func setNode(isUserPremium: Bool) {
        let switchedNode = isUserPremium ? premiumNode : freemiumNode
        executeCommand(SwitchNavigationCommand(switchedNode: switchedNode))
    }

    private var premiumNode: NavigationNode {
        SubscriptionPremiumNavigationNode(inputData: SubscriptionPremiumInputData())
    }

    private var freemiumNode: NavigationNode {
        SubscriptionFreemiumNavigationNode(inputData: SubscriptionFreemiumInputData())
    }

}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Combine
import SubscriptionPremium
import SubscriptionFreemium

@SwitchedNavigationNode
public final class SubscriptionNavigationNode {

    public var switchedNode: (any NavigationNode)?
    private let inputData: SubscriptionInputData
    private let flagsRepository: FlagsRepository

    public init(inputData: SubscriptionInputData, flagsRepository: FlagsRepository) {
        self.inputData = inputData
        self.flagsRepository = flagsRepository
    }

    public func body(for content: SwitchedNavigationNodeView<SubscriptionNavigationNode>) -> some View {
        content
            .onReceive(flagsRepository.$isUserPremium) { [weak self] in self?.switchNode(isUserPremium: $0) }
    }

    private func switchNode(isUserPremium: Bool) {
        execute(
            .switchNode(
                isUserPremium
                    ? SubscriptionPremiumNavigationNode(inputData: SubscriptionPremiumInputData())
                    : SubscriptionFreemiumNavigationNode(inputData: SubscriptionFreemiumInputData())
            )
        )
    }

}

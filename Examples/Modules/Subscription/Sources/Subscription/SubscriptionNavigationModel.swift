import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Combine
import SubscriptionPremium
import SubscriptionFreemium

@SwitchedNavigationModel
public final class SubscriptionNavigationModel {

    public var switchedModel: (any NavigationModel)?

    private let inputData: SubscriptionInputData
    private let flagsRepository: FlagsRepository

    public init(inputData: SubscriptionInputData, flagsRepository: FlagsRepository) {
        self.inputData = inputData
        self.flagsRepository = flagsRepository
    }

    public func body(for content: SwitchedNavigationModelView<SubscriptionNavigationModel>) -> some View {
        content
            .onReceive(flagsRepository.$isUserPremium) { [weak self] in self?.switchModel(isUserPremium: $0) }
    }

    private func switchModel(isUserPremium: Bool) {
        execute(
            .switchModel(
                isUserPremium
                    ? SubscriptionPremiumNavigationModel(inputData: SubscriptionPremiumInputData())
                    : SubscriptionFreemiumNavigationModel(inputData: SubscriptionFreemiumInputData())
            )
        )
    }

}

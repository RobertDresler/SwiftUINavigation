import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@NavigationModel
public final class SubscriptionPremiumNavigationModel {

    lazy var model = SubscriptionPremiumModel(
        navigationModel: self,
        flagsRepository: flagsRepository
    )

    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        SubscriptionPremiumView(model: model)
    }

    func buyMeCoffee() {
        let alertInputData = AlertInputData(
            title: "Support Me with a Coffee!",
            message: "If you'd like to support me further, please go to the very bottom of the GitHub README and find the 'Buy me a coffee' link.",
            actions: [
                AlertInputData.Action(
                    id: "cancel",
                    title: "Cancel"
                ),
                AlertInputData.Action(
                    id: "buyCoffee",
                    title: "Got it!"
                )
            ]
        )
        execute(.present(.alert(alertInputData)))
    }

}

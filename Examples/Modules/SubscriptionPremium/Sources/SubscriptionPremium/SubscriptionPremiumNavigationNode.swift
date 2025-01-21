import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class SubscriptionPremiumNavigationNode: NavigationNode {

    private let inputData: SubscriptionPremiumInputData

    public init(inputData: SubscriptionPremiumInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(SubscriptionPremiumView(inputData: inputData))
    }

    func buyMeCoffee() {
        executeCommand(
            PresentNavigationCommand(
                presentedNode: AlertPresentedNavigationNode(
                    inputData: AlertInputData(
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
                )
            )
        )
    }

}

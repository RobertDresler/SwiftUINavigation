import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class SubscriptionFreemiumNavigationNode: NavigationNode {

    private let inputData: SubscriptionFreemiumInputData

    public init(inputData: SubscriptionFreemiumInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(SubscriptionFreemiumView(inputData: inputData))
    }

}

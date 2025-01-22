import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationNode
public final class SubscriptionFreemiumNavigationNode {

    private let inputData: SubscriptionFreemiumInputData

    public init(inputData: SubscriptionFreemiumInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        SubscriptionFreemiumView(inputData: inputData)
    }

}

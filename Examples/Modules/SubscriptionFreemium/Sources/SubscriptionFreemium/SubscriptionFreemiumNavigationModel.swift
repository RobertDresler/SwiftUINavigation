import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class SubscriptionFreemiumNavigationModel {

    private let inputData: SubscriptionFreemiumInputData

    public init(inputData: SubscriptionFreemiumInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        SubscriptionFreemiumView(inputData: inputData)
    }

}

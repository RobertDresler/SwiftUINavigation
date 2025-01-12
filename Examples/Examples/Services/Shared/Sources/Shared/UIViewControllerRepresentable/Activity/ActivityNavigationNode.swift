import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ActivityNavigationNode: NavigationNode {

    private let inputData: ActivityInputData

    public init(inputData: ActivityInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(
            ActivityView(inputData: inputData)
                .presentationDetents([.medium])
        )
    }

}

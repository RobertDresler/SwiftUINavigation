import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class StartNavigationNode: SwiftUINavigationNode {

    private let inputData: StartInputData

    public init(inputData: StartInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(StartView(inputData: inputData))
    }

}

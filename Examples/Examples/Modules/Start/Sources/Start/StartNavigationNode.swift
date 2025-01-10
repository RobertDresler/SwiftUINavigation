import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class StartNavigationNode: NavigationNode {

    private let inputData: StartInputData

    public init(inputData: StartInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(StartView(inputData: inputData))
    }

}

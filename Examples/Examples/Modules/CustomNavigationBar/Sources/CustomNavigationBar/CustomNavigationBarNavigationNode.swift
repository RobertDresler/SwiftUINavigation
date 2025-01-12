import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class CustomNavigationBarNavigationNode: NavigationNode {

    private let inputData: CustomNavigationBarInputData

    public init(inputData: CustomNavigationBarInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(CustomNavigationBarView(inputData: inputData))
    }

    func dropLast() {
        executeCommand(StackDropLastNavigationCommand())
    }

}

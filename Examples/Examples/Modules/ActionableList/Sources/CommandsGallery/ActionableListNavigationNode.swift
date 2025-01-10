import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ActionableListNavigationNode: NavigationNode {

    private let inputData: ActionableListInputData

    public init(inputData: ActionableListInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(ActionableListView(inputData: inputData))
    }

}


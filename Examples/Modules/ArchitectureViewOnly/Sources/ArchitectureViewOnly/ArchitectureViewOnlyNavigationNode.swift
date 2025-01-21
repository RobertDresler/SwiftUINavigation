import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ArchitectureViewOnlyNavigationNode: NavigationNode {

    private let inputData: ArchitectureViewOnlyInputData

    public init(inputData: ArchitectureViewOnlyInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(ArchitectureViewOnlyView(inputData: inputData))
    }

    func hide() {
        executeCommand(ResolvedHideNavigationCommand())
    }

}

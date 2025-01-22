import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationNode
public final class ArchitectureViewOnlyNavigationNode {

    private let inputData: ArchitectureViewOnlyInputData

    public init(inputData: ArchitectureViewOnlyInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ArchitectureViewOnlyView(inputData: inputData)
    }

    func hide() {
        executeCommand(ResolvedHideNavigationCommand())
    }

}

import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class ArchitectureViewOnlyNavigationModel {

    private let inputData: ArchitectureViewOnlyInputData

    public init(inputData: ArchitectureViewOnlyInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ArchitectureViewOnlyView(inputData: inputData)
    }

    func hide() {
        execute(.hide())
    }

}

import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class ArchitectureExampleNavigationModel {

    lazy var viewModel = ArchitectureExampleViewModel(
        inputData: inputData,
        navigationModel: self
    )
    
    private let inputData: ArchitectureExampleInputData

    public init(inputData: ArchitectureExampleInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ArchitectureExampleView(viewModel: viewModel)
    }

    func hide() {
        execute(.hide())
    }

}

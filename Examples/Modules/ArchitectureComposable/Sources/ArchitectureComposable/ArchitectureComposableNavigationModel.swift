import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class ArchitectureComposableNavigationModel {

    private let inputData: ArchitectureComposableInputData

    public init(inputData: ArchitectureComposableInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ArchitectureComposableView(
            viewModel: ArchitectureComposableViewModel(
                inputData: inputData,
                eventHandler: { [weak self] event in
                    switch event {
                    case .hide:
                        self?.hide()
                    }
                }
            )
        )
    }

    private func hide() {
        execute(.hide())
    }

}

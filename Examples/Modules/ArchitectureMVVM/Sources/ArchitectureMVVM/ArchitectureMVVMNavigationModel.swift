import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class ArchitectureMVVMNavigationModel {

    private let inputData: ArchitectureMVVMInputData

    public init(inputData: ArchitectureMVVMInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ArchitectureMVVMView(
            viewModel: ArchitectureMVVMViewModel(
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

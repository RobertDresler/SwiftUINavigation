import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ArchitectureComposableNavigationNode: NavigationNode {

    private let inputData: ArchitectureComposableInputData

    public init(inputData: ArchitectureComposableInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(
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
        )
    }

    private func hide() {
        executeCommand(ResolvedHideNavigationCommand())
    }

}

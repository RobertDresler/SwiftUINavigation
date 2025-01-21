import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ArchitectureMVVMNavigationNode: NavigationNode {

    private let inputData: ArchitectureMVVMInputData

    public init(inputData: ArchitectureMVVMInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(
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
        )
    }

    private func hide() {
        executeCommand(ResolvedHideNavigationCommand())
    }

}

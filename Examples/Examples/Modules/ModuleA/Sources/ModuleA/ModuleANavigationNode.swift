import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ModuleANavigationNode: NavigationNode {

    private let inputData: ModuleAInputData

    public init(inputData: ModuleAInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(ModuleAView(inputData: inputData))
    }

    public func presentAlert(sourceID: String) {
        executeCommand(
            PresentOnGivenNodeNavigationCommand(
                presentedNode: AlertPresentedNavigationNode(
                    inputData: AlertInputData(
                        title: "title",
                        message: "message message"
                    ),
                    sourceID: sourceID
                )
            )
        )
    }

}


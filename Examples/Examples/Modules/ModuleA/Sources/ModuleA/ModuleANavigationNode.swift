import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ModuleANavigationNode: SwiftUINavigationNode {

    private let inputData: ModuleAInputData

    public init(inputData: ModuleAInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(ModuleAView(inputData: inputData))
    }

}


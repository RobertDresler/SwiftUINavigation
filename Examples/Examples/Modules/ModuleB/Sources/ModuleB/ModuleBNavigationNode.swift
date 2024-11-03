import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class ModuleBNavigationNode: NavigationNode {

    private let inputData: ModuleBInputData

    public init(inputData: ModuleBInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(ModuleBView(inputData: inputData))
    }

}


import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class SettingsNavigationNode: NavigationNode {

    private let inputData: SettingsInputData

    public init(inputData: SettingsInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(SettingsView(inputData: inputData))
    }

}


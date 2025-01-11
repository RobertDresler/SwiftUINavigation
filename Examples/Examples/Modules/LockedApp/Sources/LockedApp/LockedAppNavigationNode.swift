import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class LockedAppNavigationNode: NavigationNode {

    private let inputData: LockedAppInputData

    public init(inputData: LockedAppInputData) {
        self.inputData = inputData
        super.init()
    }

    public override var view: AnyView {
        AnyView(LockedAppView(inputData: inputData))
    }

}

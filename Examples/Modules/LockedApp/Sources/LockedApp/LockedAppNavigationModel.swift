import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class LockedAppNavigationModel {

    private let inputData: LockedAppInputData

    public init(inputData: LockedAppInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        LockedAppView(inputData: inputData)
    }

}

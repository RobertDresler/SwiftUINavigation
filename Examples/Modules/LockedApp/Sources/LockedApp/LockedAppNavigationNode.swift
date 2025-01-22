import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationNode
public final class LockedAppNavigationNode {

    private let inputData: LockedAppInputData

    public init(inputData: LockedAppInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        LockedAppView(inputData: inputData)
    }

}

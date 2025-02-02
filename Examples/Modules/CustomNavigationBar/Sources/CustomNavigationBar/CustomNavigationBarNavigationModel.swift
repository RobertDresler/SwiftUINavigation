import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationModel
public final class CustomNavigationBarNavigationModel {

    private let inputData: CustomNavigationBarInputData

    public init(inputData: CustomNavigationBarInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        CustomNavigationBarView(inputData: inputData)
    }

    func dropLast() {
        execute(.stackDropLast())
    }

}

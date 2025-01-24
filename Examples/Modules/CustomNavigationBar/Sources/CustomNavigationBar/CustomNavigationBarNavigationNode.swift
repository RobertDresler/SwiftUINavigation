import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@NavigationNode
public final class CustomNavigationBarNavigationNode {

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

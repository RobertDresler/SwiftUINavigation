import SwiftUINavigation
import SwiftUI

@NavigationNode
public final class ActivityNavigationNode {

    private let inputData: ActivityInputData

    public init(inputData: ActivityInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ActivityView(inputData: inputData)
            .presentationDetents([.medium])
    }

}

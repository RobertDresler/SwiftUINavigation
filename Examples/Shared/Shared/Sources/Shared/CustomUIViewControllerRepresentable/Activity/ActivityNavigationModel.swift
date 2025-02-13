import SwiftUINavigation
import SwiftUI

#if os(iOS)
@NavigationModel
public final class ActivityNavigationModel {

    private let inputData: ActivityInputData

    public init(inputData: ActivityInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ActivityView(inputData: inputData)
            .presentationDetents([.medium])
    }

}
#endif

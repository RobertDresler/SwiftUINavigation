import SwiftUI

@NavigationModel
public final class SFSafariNavigationModel {

    private let inputData: SFSafariInputData

    public init(inputData: SFSafariInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        SFSafariView(inputData: inputData)
    }

}

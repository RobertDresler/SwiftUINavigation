import SwiftUI

public final class SFSafariNavigationNode: NavigationNode {

    private let inputData: SFSafariInputData

    public init(inputData: SFSafariInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(SFSafariView(inputData: inputData))
    }

}

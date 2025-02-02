import SwiftUI

public struct RootNavigationView<Model: NavigationModel>: View {

    @ObservedObject private var rootModel: Model

    // MARK: Init

    public init(rootModel: Model) {
        self.rootModel = rootModel
        Task { @MainActor in
            await rootModel.startIfNeeded(parent: nil)
        }
    }

    public var body: some View {
        NavigationModelResolvedView(model: rootModel)
    }

}

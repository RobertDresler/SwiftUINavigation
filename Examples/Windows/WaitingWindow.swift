import SwiftUI
import Waiting
import SwiftUINavigation
import ExamplesNavigation

struct WaitingWindow: View {

    @StateObject private var rootModel: WaitingNavigationModel

    init(dependencies: Dependencies) {
        self._rootModel = StateObject(
            wrappedValue: WaitingNavigationModel(
                flagsRepository: dependencies.flagsRepository
            )
        )
    }

    var body: some View {
        RootNavigationView(rootModel: rootModel)
    }

}

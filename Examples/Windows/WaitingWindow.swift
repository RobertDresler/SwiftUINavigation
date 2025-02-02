import SwiftUI
import Waiting
import SwiftUINavigation
import ExamplesNavigation

struct WaitingWindow: View {

    @StateObject private var rootNode: WaitingNavigationNode

    init(dependencies: Dependencies) {
        self._rootNode = StateObject(
            wrappedValue: WaitingNavigationNode(
                inputData: WaitingInputData(),
                flagsRepository: dependencies.flagsRepository
            )
        )
    }

    var body: some View {
        RootNavigationView(rootNode: rootNode)
    }

}

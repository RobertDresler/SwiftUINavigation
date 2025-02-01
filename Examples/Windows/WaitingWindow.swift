import SwiftUI
import Waiting
import SwiftUINavigation
import ExamplesNavigation

struct WaitingWindow: View {

    @ObservedObject private var rootNode: WaitingNavigationNode
    var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.rootNode = WaitingNavigationNode(
            inputData: WaitingInputData(),
            flagsRepository: dependencies.flagsRepository
        )
    }

    var body: some View {
        NavigationWindow(rootNode: rootNode)
    }

}

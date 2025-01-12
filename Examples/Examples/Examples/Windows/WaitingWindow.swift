import SwiftUI
import Waiting
import SwiftUINavigation
import ExamplesNavigation

struct WaitingWindow: View {

    var dependencies: Dependencies

    var body: some View {
        NavigationWindow(
            rootNode: WaitingNavigationNode(
                inputData: WaitingInputData(),
                flagsRepository: dependencies.flagsRepository
            ),
            defaultDeepLinkHandler: dependencies.defaultDeepLinkHandler
        )
    }

}

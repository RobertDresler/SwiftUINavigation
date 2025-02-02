import SwiftUINavigation
import SwiftUI
import StoreKit
import App
import Shared

struct AppWindow: View {

    @Environment(\.requestReview) private var requestReview
    @StateObject private var rootNode: AppNavigationNode

    var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self._rootNode = StateObject(
            wrappedValue: AppNavigationNode(
                flagsRepository: dependencies.flagsRepository,
                deepLinkForwarderService: dependencies.deepLinkForwarderService,
                onboardingService: dependencies.onboardingService
            )
        )
    }

    var body: some View {
        RootNavigationView(rootNode: rootNode)
            .registerCustomPresentableNavigationNodes([PhotosPickerPresentedNavigationNode.self])
            .navigationEnvironmentTriggerHandler(ExamplesNavigationEnvironmentTriggerHandler())
            .requestReviewProxy(requestReview)
            .environmentObject(dependencies.flagsRepository)
            .environmentObject(dependencies.notificationsService)
            .environmentObject(dependencies.deepLinkForwarderService)
            .environmentObject(dependencies.onboardingService)
            .environmentObject(dependencies.deepLinkHandler)
            .onShake { rootNode.printDebugGraph() }
    }

}

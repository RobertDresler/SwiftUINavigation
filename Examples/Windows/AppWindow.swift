import SwiftUINavigation
import SwiftUI
import StoreKit
import App
import Shared

struct AppWindow: View {

    @Environment(\.requestReview) private var requestReview
    @ObservedObject private var rootNode: AppNavigationNode

    var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.rootNode = AppNavigationNode(
            flagsRepository: dependencies.flagsRepository,
            deepLinkForwarderService: dependencies.deepLinkForwarderService,
            onboardingService: dependencies.onboardingService
        )
    }

    var body: some View {
        NavigationWindow(
            rootNode: rootNode,
            defaultDeepLinkHandler: dependencies.defaultDeepLinkHandler
        )
            .registerCustomPresentableNavigationNodes([PhotosPickerPresentedNavigationNode.self])
            .navigationEnvironmentTriggerHandler(ExamplesNavigationEnvironmentTriggerHandler())
            .requestReviewProxy(requestReview)
            .environmentObject(dependencies.flagsRepository)
            .environmentObject(dependencies.notificationsService)
            .environmentObject(dependencies.deepLinkForwarderService)
            .environmentObject(dependencies.onboardingService)
            .onShake { rootNode.printDebugGraph() }
    }

}

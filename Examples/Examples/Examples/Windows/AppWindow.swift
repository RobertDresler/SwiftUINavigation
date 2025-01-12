import SwiftUINavigation
import SwiftUI
import StoreKit
import App
import Shared

struct AppWindow: View {

    @Environment(\.requestReview) private var requestReview

    var dependencies: Dependencies

    var body: some View {
        NavigationWindow(
            rootNode: AppNavigationNode(
                flagsRepository: dependencies.flagsRepository,
                deepLinkForwarderService: dependencies.deepLinkForwarderService,
                onboardingService: dependencies.onboardingService
            ),
            defaultDeepLinkHandler: dependencies.defaultDeepLinkHandler
        )
            .registerCustomPresentableNavigationNodes([PhotosPickerPresentedNavigationNode.self])
            .navigationEnvironmentTriggerHandler(ExamplesNavigationEnvironmentTriggerHandler())
            .requestReviewProxy(requestReview)
            .environmentObject(dependencies.flagsRepository)
            .environmentObject(dependencies.notificationsService)
            .environmentObject(dependencies.deepLinkForwarderService)
            .environmentObject(dependencies.onboardingService)
    }

}

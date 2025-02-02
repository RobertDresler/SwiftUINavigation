import SwiftUINavigation
import SwiftUI
import StoreKit
import App
import Shared

struct AppWindow: View {

    @Environment(\.requestReview) private var requestReview
    @StateObject private var rootModel: AppNavigationModel

    var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self._rootModel = StateObject(
            wrappedValue: AppNavigationModel(
                flagsRepository: dependencies.flagsRepository,
                deepLinkForwarderService: dependencies.deepLinkForwarderService,
                onboardingService: dependencies.onboardingService
            )
        )
    }

    var body: some View {
        RootNavigationView(rootModel: rootModel)
            .registerCustomPresentableNavigationModels([PhotosPickerPresentedNavigationModel.self])
            .navigationEnvironmentTriggerHandler(ExamplesNavigationEnvironmentTriggerHandler())
            .requestReviewProxy(requestReview)
            .environmentObject(dependencies.flagsRepository)
            .environmentObject(dependencies.notificationsService)
            .environmentObject(dependencies.deepLinkForwarderService)
            .environmentObject(dependencies.onboardingService)
            .environmentObject(dependencies.deepLinkHandler)
            .onShake { rootModel.printDebugGraph() }
    }

}

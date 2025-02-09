import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class OnboardingResultNavigationModel {

    private let onboardingService: OnboardingService

    public init(onboardingService: OnboardingService) {
        self.onboardingService = onboardingService
    }

    public var body: some View {
        OnboardingResultView()
    }

    func continueInOnboarding() {
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: .result))
    }

}

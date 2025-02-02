import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

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

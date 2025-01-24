import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

@NavigationNode
public final class OnboardingResultNavigationNode {

    private let inputData: OnboardingResultInputData
    private let onboardingService: OnboardingService

    public init(inputData: OnboardingResultInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
    }

    public var body: some View {
        OnboardingResultView(inputData: inputData)
    }

    func continueInOnboarding() {
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: .result))
    }

}

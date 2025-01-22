import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

@NavigationNode
public final class OnboardingQuestionNavigationNode {

    private let inputData: OnboardingQuestionInputData
    private let onboardingService: OnboardingService

    public init(inputData: OnboardingQuestionInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
    }

    public var body: some View {
        OnboardingQuestionView(inputData: inputData)
    }

    func continueInOnboarding() {
        executeCommand(onboardingService.makeMoveInOnboardingCommand(previousStepID: .question))
    }

}

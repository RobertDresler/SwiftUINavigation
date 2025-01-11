import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

public final class OnboardingQuestionNavigationNode: NavigationNode {

    private let inputData: OnboardingQuestionInputData
    private let onboardingService: OnboardingService

    public init(inputData: OnboardingQuestionInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
        super.init()
    }

    public override var view: AnyView {
        AnyView(OnboardingQuestionView(inputData: inputData))
    }

    func continueInOnboarding() {
        executeCommand(onboardingService.makeMoveInOnboardingCommand(previousStepID: .question))
    }

}

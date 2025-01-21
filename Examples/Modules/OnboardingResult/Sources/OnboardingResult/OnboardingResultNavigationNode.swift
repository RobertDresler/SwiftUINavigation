import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

public final class OnboardingResultNavigationNode: NavigationNode {

    private let inputData: OnboardingResultInputData
    private let onboardingService: OnboardingService

    public init(inputData: OnboardingResultInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
        super.init()
    }

    public override var view: AnyView {
        AnyView(OnboardingResultView(inputData: inputData))
    }

    func continueInOnboarding() {
        executeCommand(onboardingService.makeMoveInOnboardingCommand(previousStepID: .result))
    }

}

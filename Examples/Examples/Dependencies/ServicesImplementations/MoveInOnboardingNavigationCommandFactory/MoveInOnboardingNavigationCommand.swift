import SwiftUINavigation
import Foundation
import OnboardingQuestion
import OnboardingResult
import Shared

struct MoveInOnboardingNavigationCommand: NavigationCommand {

    func execute(on model: any NavigationModel) {
        if previousStepID == nil {
            onboardingService.startOnboarding()
        }
        switch onboardingService.nextStep(for: previousStepID) {
        case .question(let inputData):
            StackAppendNavigationCommand(
                appendedModel: OnboardingQuestionNavigationModel(
                    inputData: inputData,
                    onboardingService: onboardingService
                )
            ).execute(on: model)
        case .result:
            StackAppendNavigationCommand(
                appendedModel: OnboardingResultNavigationModel(
                    onboardingService: onboardingService
                )
            ).execute(on: model)
        case .none:
            onboardingService.finishOnboarding()
        }
    }

    private let onboardingService: OnboardingService
    private let previousStepID: OnboardingStepID?

    init(onboardingService: OnboardingService, previousStepID: OnboardingStepID?) {
        self.onboardingService = onboardingService
        self.previousStepID = previousStepID
    }

}

import SwiftUINavigation
import Foundation
import OnboardingService
import FlagsRepository
import OnboardingQuestion
import OnboardingResult

public struct MoveInOnboardingNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
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
        case .result(let inputData):
            StackAppendNavigationCommand(
                appendedModel: OnboardingResultNavigationModel(
                    inputData: inputData,
                    onboardingService: onboardingService
                )
            ).execute(on: model)
        case .none:
            onboardingService.finishOnboarding()
        }
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        true
    }

    private let onboardingService: OnboardingService
    private let previousStepID: OnboardingStepID?

    public init(onboardingService: OnboardingService, previousStepID: OnboardingStepID?) {
        self.onboardingService = onboardingService
        self.previousStepID = previousStepID
    }

}

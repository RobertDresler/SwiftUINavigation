import SwiftUINavigation
import Foundation
import OnboardingService
import FlagsRepository
import OnboardingQuestion
import OnboardingResult

public struct MoveInOnboardingNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        if previousStepID == nil {
            onboardingService.startOnboarding()
        }
        switch onboardingService.nextStep(for: previousStepID) {
        case .question(let inputData):
            StackAppendNavigationCommand(
                appendedNode: OnboardingQuestionNavigationNode(
                    inputData: inputData,
                    onboardingService: onboardingService
                )
            ).execute(on: node)
        case .result(let inputData):
            StackAppendNavigationCommand(
                appendedNode: OnboardingResultNavigationNode(
                    inputData: inputData,
                    onboardingService: onboardingService
                )
            ).execute(on: node)
        case .none:
            onboardingService.finishOnboarding()
        }
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        true
    }

    private let onboardingService: OnboardingService
    private let previousStepID: OnboardingStepID?

    public init(onboardingService: OnboardingService, previousStepID: OnboardingStepID?) {
        self.onboardingService = onboardingService
        self.previousStepID = previousStepID
    }

}

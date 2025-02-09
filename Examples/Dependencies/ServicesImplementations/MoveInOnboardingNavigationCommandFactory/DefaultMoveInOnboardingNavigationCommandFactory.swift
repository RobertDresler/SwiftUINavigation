import SwiftUINavigation
import Shared

final class DefaultMoveInOnboardingNavigationCommandFactory: MoveInOnboardingNavigationCommandFactory {

    // MARK: MoveInOnboardingNavigationCommandFactory

    func makeMoveInOnboardingCommand(
        onboardingService: OnboardingService,
        previousStepID: OnboardingStepID?
    ) -> NavigationCommand {
        MoveInOnboardingNavigationCommand(onboardingService: onboardingService, previousStepID: previousStepID)
    }

    // MARK: Other

    init() {}

}

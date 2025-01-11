import SwiftUINavigation
import OnboardingService

public final class DefaultOnboardingNavigationCommandFactory: OnboardingNavigationCommandFactory {

    // MARK: OnboardingNavigationCommandFactory

    public func makeMoveInOnboardingCommand(
        onboardingService: OnboardingService,
        previousStepID: OnboardingStepID?
    ) -> NavigationCommand {
        MoveInOnboardingNavigationCommand(onboardingService: onboardingService, previousStepID: previousStepID)
    }

    // MARK: Other

    public init() {}

}

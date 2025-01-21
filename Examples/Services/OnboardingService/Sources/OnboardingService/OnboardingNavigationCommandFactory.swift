import SwiftUINavigation

public protocol OnboardingNavigationCommandFactory {
    @MainActor
    func makeMoveInOnboardingCommand(
        onboardingService: OnboardingService,
        previousStepID: OnboardingStepID?
    ) -> NavigationCommand
}

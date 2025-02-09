import SwiftUINavigation

public protocol MoveInOnboardingNavigationCommandFactory {
    @MainActor
    func makeMoveInOnboardingCommand(
        onboardingService: OnboardingService,
        previousStepID: OnboardingStepID?
    ) -> NavigationCommand
}

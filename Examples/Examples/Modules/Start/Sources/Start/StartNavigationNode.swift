import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

public final class StartNavigationNode: NavigationNode {

    private let inputData: StartInputData
    private let onboardingService: OnboardingService

    public init(inputData: StartInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
        super.init()
    }

    public override var view: AnyView {
        AnyView(StartView(inputData: inputData))
    }

    func startOnboarding() {
        executeCommand(onboardingService.makeMoveInOnboardingCommand(previousStepID: nil))
    }

}

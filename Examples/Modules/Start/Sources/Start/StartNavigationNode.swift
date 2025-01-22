import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

@NavigationNode
public final class StartNavigationNode {

    private let inputData: StartInputData
    private let onboardingService: OnboardingService

    public init(inputData: StartInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
    }

    public var body: some View {
        StartView(inputData: inputData)
    }

    func startOnboarding() {
        executeCommand(onboardingService.makeMoveInOnboardingCommand(previousStepID: nil))
    }

}

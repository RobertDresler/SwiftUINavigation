import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

@NavigationModel
public final class StartNavigationModel {

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
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: nil))
    }

}

import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class OnboardingQuestionNavigationModel {

    lazy var viewModel = OnboardingQuestionViewModel(
        inputData: inputData,
        navigationModel: self,
        onboardingService: onboardingService
    )
    private let inputData: OnboardingQuestionInputData
    private let onboardingService: OnboardingService

    public init(inputData: OnboardingQuestionInputData, onboardingService: OnboardingService) {
        self.inputData = inputData
        self.onboardingService = onboardingService
    }

    public var body: some View {
        OnboardingQuestionView(viewModel: viewModel)
    }

    func continueInOnboarding() {
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: .question))
    }

}

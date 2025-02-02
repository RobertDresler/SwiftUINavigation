import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

@NavigationModel
public final class OnboardingQuestionNavigationModel {

    lazy var model = OnboardingQuestionModel(
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
        OnboardingQuestionView(model: model)
    }

    func continueInOnboarding() {
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: .question))
    }

}

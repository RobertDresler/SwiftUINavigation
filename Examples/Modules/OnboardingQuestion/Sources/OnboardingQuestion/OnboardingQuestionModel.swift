import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService

@MainActor final class OnboardingQuestionModel: ObservableObject {

    @Published var selectedAnswer: OnboardingService.State.QuestionAnswer?
    let inputData: OnboardingQuestionInputData
    private unowned let navigationModel: OnboardingQuestionNavigationModel
    private let onboardingService: OnboardingService

    init(
        inputData: OnboardingQuestionInputData,
        navigationModel: OnboardingQuestionNavigationModel,
        onboardingService: OnboardingService
    ) {
        self.inputData = inputData
        self.navigationModel = navigationModel
        self.onboardingService = onboardingService
    }

    func continueInOnboarding() {
        onboardingService.state.questionAnswer = selectedAnswer
        navigationModel.continueInOnboarding()
    }

}


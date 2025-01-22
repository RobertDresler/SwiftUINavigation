import SwiftUI
import ExamplesNavigation
import SwiftUINavigation
import FlagsRepository

public final class OnboardingService: ObservableObject {

    public struct State {

        public enum QuestionAnswer {
            case xcode
            case myself
        }

        public var questionAnswer: QuestionAnswer?

    }

    public static func makeStub() -> OnboardingService {
        class StubOnboardingNavigationCommandFactory: OnboardingNavigationCommandFactory {
            func makeMoveInOnboardingCommand(
                onboardingService: OnboardingService,
                previousStepID: OnboardingStepID?
            ) -> NavigationCommand {
                fatalError()
            }
        }
        return OnboardingService(
            onboardingNavigationCommandFactory: StubOnboardingNavigationCommandFactory(),
            flagsRepository: FlagsRepository()
        )
    }

    public func nextStep(for stepID: OnboardingStepID?) -> OnboardingStep? {
        switch stepID {
        case .none:
            .question(OnboardingQuestionInputData(usage: .start))
        case .question:
            switch state.questionAnswer {
            case .myself:
                .result(OnboardingResultInputData())
            case .xcode, .none:
                .question(OnboardingQuestionInputData(usage: .wrongAnswer))
            }
        case .result:
            nil
        }
    }

    public func answerQuestion(_ answer: State.QuestionAnswer) {
        state.questionAnswer = answer
    }

    public func startOnboarding() {
        state = State()
    }

    public func finishOnboarding() {
        flagsRepository.isUserLogged = true
    }

    @MainActor
    public func makeMoveInOnboardingCommand(previousStepID: OnboardingStepID?) -> NavigationCommand {
        onboardingNavigationCommandFactory.makeMoveInOnboardingCommand(
            onboardingService: self,
            previousStepID: previousStepID
        )
    }

    @Published public var state = State()

    private let onboardingNavigationCommandFactory: OnboardingNavigationCommandFactory
    private let flagsRepository: FlagsRepository

    public init(
        onboardingNavigationCommandFactory: OnboardingNavigationCommandFactory,
        flagsRepository: FlagsRepository
    ) {
        self.onboardingNavigationCommandFactory = onboardingNavigationCommandFactory
        self.flagsRepository = flagsRepository
    }

}

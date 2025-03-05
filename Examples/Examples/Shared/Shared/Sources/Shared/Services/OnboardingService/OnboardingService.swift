import SwiftUI
import SwiftUINavigation

public final class OnboardingService: ObservableObject {

    public struct State {

        public enum QuestionAnswer {
            case xcode
            case myself
        }

        public var questionAnswer: QuestionAnswer?

    }

    public static func makeStub() -> OnboardingService {
        class StubMoveInOnboardingNavigationCommandFactory: MoveInOnboardingNavigationCommandFactory {
            func makeMoveInOnboardingCommand(
                onboardingService: OnboardingService,
                previousStepID: OnboardingStepID?
            ) -> NavigationCommand {
                fatalError()
            }
        }
        return OnboardingService(
            moveInOnboardingNavigationCommandFactory: StubMoveInOnboardingNavigationCommandFactory(),
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
                .result
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
        moveInOnboardingNavigationCommandFactory.makeMoveInOnboardingCommand(
            onboardingService: self,
            previousStepID: previousStepID
        )
    }

    @Published public var state = State()

    private let moveInOnboardingNavigationCommandFactory: MoveInOnboardingNavigationCommandFactory
    private let flagsRepository: FlagsRepository

    public init(
        moveInOnboardingNavigationCommandFactory: MoveInOnboardingNavigationCommandFactory,
        flagsRepository: FlagsRepository
    ) {
        self.moveInOnboardingNavigationCommandFactory = moveInOnboardingNavigationCommandFactory
        self.flagsRepository = flagsRepository
    }

}

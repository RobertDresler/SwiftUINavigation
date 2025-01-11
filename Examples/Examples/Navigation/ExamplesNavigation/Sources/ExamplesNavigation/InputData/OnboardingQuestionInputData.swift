public struct OnboardingQuestionInputData {

    public enum Usage {
        case start
        case wrongAnswer
    }

    public let usage: Usage

    public init(usage: Usage) {
        self.usage = usage
    }

}

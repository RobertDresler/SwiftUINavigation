import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared
import OnboardingService

struct OnboardingQuestionView: View {

    @EnvironmentNavigationModel private var navigationModel: OnboardingQuestionNavigationModel
    @ObservedObject var model: OnboardingQuestionModel

    var body: some View {
        VStack(spacing: 0) {
            title
            Spacer()
            VStack(spacing: 24) {
                question
                answersPicker
            }
            Spacer()
            continueButton
        }
            .padding()
            .background(SharedColor.backgroundGray)
    }

    private var title: some View {
        Text(titleText)
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var titleText: String {
        switch model.inputData.usage {
        case .start:
            "Let's begin!"
        case .wrongAnswer:
            "Incorrect answer – time to blame yourself!"
        }
    }

    private var question: some View {
        Text("As part of the onboarding flow, answer this:\n\nYour app is crashing. Do you blame yourself or Xcode first?")
            .font(.title3)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(SharedColor.grayscalePrimary)
    }

    private var answersPicker: some View {
        VStack(spacing: 8) {
            answerButton(for: .xcode)
            answerButton(for: .myself)
        }
    }

    private func answerButton(
        for answer: OnboardingService.State.QuestionAnswer
    ) -> some View {
        Button(action: { model.selectedAnswer = answer }) {
            HStack(spacing: 12) {
                Image(systemName: answer == model.selectedAnswer ? "checkmark.circle.fill" : "circle")
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(answer == model.selectedAnswer ? .blue : .gray)
                    .font(.system(size: 24))
                    .frame(width: 24)
                Text({
                    switch answer {
                    case .xcode:
                        "Xcode – obviously. It’s tradition."
                    case .myself:
                        "Myself – but only after swearing at Xcode for 10 minutes."
                    }
                }())
                    .foregroundStyle(SharedColor.grayscalePrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
            }
                .padding(12)
                .background(SharedColor.cardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    private var continueButton: some View {
        PrimaryButton(title: "Continue", action: { model.continueInOnboarding() })
            .opacity(model.selectedAnswer == nil ? 0.5 : 1)
            .disabled(model.selectedAnswer == nil)
    }

}

#Preview {
    OnboardingQuestionNavigationModel(
        inputData: OnboardingQuestionInputData(usage: .start),
        onboardingService: OnboardingService.makeStub()
    ).body
}

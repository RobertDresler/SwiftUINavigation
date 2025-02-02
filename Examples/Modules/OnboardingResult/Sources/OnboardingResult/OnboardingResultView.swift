import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository
import Shared
import OnboardingService

struct OnboardingResultView: View {

    @EnvironmentNavigationModel private var navigationModel: OnboardingResultNavigationModel
    @EnvironmentObject private var flagsRepository: FlagsRepository

    var inputData: OnboardingResultInputData

    var body: some View {
        VStack(spacing: 0) {
            title
            Spacer()
            VStack(spacing: 24) {
                image
                description
            }
            Spacer()
            continueButton
        }
            .padding()
    }

    private var title: some View {
        Text("The end")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var image: some View {
        Image(systemName: "flag.pattern.checkered.2.crossed")
            .font(.system(size: 100))
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(.black)
    }

    private var description: some View {
        Text("Well done! You’ve admitted it – it’s all your fault. But hey, at least you’re honest!")
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .foregroundColor(SharedColor.grayscalePrimary)
    }

    private var continueButton: some View {
        PrimaryButton(title: "Finish onboarding", action: { continueInOnboarding() })
    }

    // MARK: Actions

    private func continueInOnboarding() {
        navigationModel.continueInOnboarding()
    }

}

#Preview {
    OnboardingResultNavigationModel(
        inputData: OnboardingResultInputData(),
        onboardingService: OnboardingService.makeStub()
    )
        .body
        .environmentObject(FlagsRepository())
}

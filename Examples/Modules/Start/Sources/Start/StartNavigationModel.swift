import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import OnboardingService
import FlagsRepository

@NavigationModel
public final class StartNavigationModel {

    lazy var model = StartModel(
        navigationModel: self,
        flagsRepository: flagsRepository
    )
    private let flagsRepository: FlagsRepository
    private let onboardingService: OnboardingService

    public init(flagsRepository: FlagsRepository, onboardingService: OnboardingService) {
        self.flagsRepository = flagsRepository
        self.onboardingService = onboardingService
    }

    public var body: some View {
        StartView(model: model)
    }

    func startOnboarding() {
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: nil))
    }

}

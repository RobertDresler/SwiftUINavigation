import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class StartNavigationModel {

    lazy var viewModel = StartViewModel(
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
        StartView(viewModel: viewModel)
    }

    func startOnboarding() {
        execute(onboardingService.makeMoveInOnboardingCommand(previousStepID: nil))
    }

}

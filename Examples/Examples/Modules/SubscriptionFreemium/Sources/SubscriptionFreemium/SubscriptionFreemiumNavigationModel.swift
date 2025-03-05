import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class SubscriptionFreemiumNavigationModel {

    lazy var viewModel = SubscriptionFreemiumViewModel(
        navigationModel: self,
        flagsRepository: flagsRepository
    )
    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        SubscriptionFreemiumView(viewModel: viewModel)
    }

}

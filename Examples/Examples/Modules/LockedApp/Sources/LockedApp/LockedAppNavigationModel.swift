import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class LockedAppNavigationModel {

    lazy var viewModel = LockedAppViewModel(
        navigationModel: self,
        flagsRepository: flagsRepository
    )
    
    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        LockedAppView(viewModel: viewModel)
    }

}

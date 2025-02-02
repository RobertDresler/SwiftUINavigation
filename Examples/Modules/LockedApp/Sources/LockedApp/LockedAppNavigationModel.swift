import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@NavigationModel
public final class LockedAppNavigationModel {

    lazy var model = LockedAppModel(
        navigationModel: self,
        flagsRepository: flagsRepository
    )
    
    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        LockedAppView(model: model)
    }

}

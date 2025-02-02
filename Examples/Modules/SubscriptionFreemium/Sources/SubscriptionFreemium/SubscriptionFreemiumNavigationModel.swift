import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@NavigationModel
public final class SubscriptionFreemiumNavigationModel {

    lazy var model = SubscriptionFreemiumModel(
        navigationModel: self,
        flagsRepository: flagsRepository
    )
    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        SubscriptionFreemiumView(model: model)
    }

}

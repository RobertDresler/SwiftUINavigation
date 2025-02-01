import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import FlagsRepository

@MainActor public final class ExamplesNavigationDeepLinkHandler: ObservableObject {

    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public func handleDeepLinkCommand(
        _ deepLink: ExamplesNavigationDeepLink,
        messageListener: NavigationMessageListener? = nil
    ) -> NavigationCommand {
        HandleNavigationDeepLinkCommand(
            flagsRepository: flagsRepository,
            deepLink: deepLink,
            messageListener: messageListener
        )
    }

}

import SwiftUI
import SwiftUINavigation
import Shared

@MainActor final class DefaultHandleDeepLinkNavigationCommandFactory: ObservableObject,
                                                                      HandleDeepLinkNavigationCommandFactory {

    // MARK: HandleDeepLinkNavigationCommandFactory

    func makeCommand(
        for deepLink: ExamplesAppNavigationDeepLink,
        messageListener: NavigationMessageListener?
    ) -> NavigationCommand {
        HandleDeepLinkNavigationCommand(
            flagsRepository: flagsRepository,
            deepLink: deepLink,
            messageListener: messageListener
        )
    }

    // MARK: Other
    
    private let flagsRepository: FlagsRepository

    init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

}

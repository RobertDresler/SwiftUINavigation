import SwiftUINavigation

public protocol HandleDeepLinkNavigationCommandFactory {
    @MainActor
    func makeCommand(
        for deepLink: ExamplesAppNavigationDeepLink,
        messageListener: NavigationMessageListener?
    ) -> NavigationCommand
}

public extension HandleDeepLinkNavigationCommandFactory {
    @MainActor
    func makeCommand(
        for deepLink: ExamplesAppNavigationDeepLink,
        messageListener: NavigationMessageListener? = nil
    ) -> NavigationCommand {
        makeCommand(for: deepLink, messageListener: messageListener)
    }
}

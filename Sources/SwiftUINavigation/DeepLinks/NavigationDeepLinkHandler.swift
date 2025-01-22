@MainActor
public protocol NavigationDeepLinkHandler {
    func handleDeepLink(
        _ deepLink: NavigationDeepLink,
        on node: any NavigationNode,
        messageListener: NavigationMessageListener?
    )
}

@MainActor
public protocol NavigationDeepLinkHandler {
    func handleDeepLink(_ deepLink: any NavigationDeepLink, on node: NavigationNode)
}

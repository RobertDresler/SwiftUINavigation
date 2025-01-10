@MainActor
public protocol NavigationDeepLinkHandler {
    func handleDeepLink(_ deepLink: NavigationDeepLink, on node: NavigationNode)
}

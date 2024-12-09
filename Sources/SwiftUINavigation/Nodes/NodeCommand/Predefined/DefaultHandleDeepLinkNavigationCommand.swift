public struct DefaultHandleDeepLinkNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.defaultDeepLinkHandler?.handleDeepLink(deepLink, on: node)
    }

    private let deepLink: any NavigationDeepLink

    public init(deepLink: any NavigationDeepLink) {
        self.deepLink = deepLink
    }

}

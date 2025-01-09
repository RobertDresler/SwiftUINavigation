public struct DefaultHandleDeepLinkNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.defaultDeepLinkHandler?.handleDeepLink(deepLink, on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        node.defaultDeepLinkHandler != nil
    }

    private let deepLink: any NavigationDeepLink

    public init(deepLink: any NavigationDeepLink) {
        self.deepLink = deepLink
    }

}

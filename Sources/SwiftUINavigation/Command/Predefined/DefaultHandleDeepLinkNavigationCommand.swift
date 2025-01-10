public struct DefaultHandleDeepLinkNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let handlerNode = handlerNode(for: node) else { return }
        handlerNode.defaultDeepLinkHandler?.handleDeepLink(deepLink, on: handlerNode)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        guard let handlerNode = handlerNode(for: node) else { return false }
        return handlerNode.defaultDeepLinkHandler != nil
    }

    private let deepLink: NavigationDeepLink

    public init(deepLink: NavigationDeepLink) {
        self.deepLink = deepLink
    }

    private func handlerNode(for node: NavigationNode) -> NavigationNode? {
        node.nearestNodeWhichCanPresent
    }

}

public struct DefaultHandleDeepLinkNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        guard let handlerNode = handlerNode(for: node) else { return }
        handlerNode.state.defaultDeepLinkHandler?.handleDeepLink(deepLink, on: handlerNode, messageListener: messageListener)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        guard let handlerNode = handlerNode(for: node) else { return false }
        return handlerNode.state.defaultDeepLinkHandler != nil
    }

    private let deepLink: NavigationDeepLink
    private let messageListener: NavigationMessageListener?

    public init(deepLink: NavigationDeepLink, messageListener: NavigationMessageListener? = nil) {
        self.deepLink = deepLink
        self.messageListener = messageListener
    }

    private func handlerNode(for node: any NavigationNode) -> (any NavigationNode)? {
        node.nearestNodeWhichCanPresent
    }

}

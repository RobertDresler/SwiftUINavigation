public struct DefaultHandleDeepLinkNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let handlerNode = handlerNode(for: node) else { return }
        handlerNode.defaultDeepLinkHandler?.handleDeepLink(deepLink, on: handlerNode, messageListener: messageListener)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        guard let handlerNode = handlerNode(for: node) else { return false }
        return handlerNode.defaultDeepLinkHandler != nil
    }

    private let deepLink: NavigationDeepLink
    private let messageListener: NavigationNode.MessageListener?

    public init(deepLink: NavigationDeepLink, messageListener: NavigationNode.MessageListener? = nil) {
        self.deepLink = deepLink
        self.messageListener = messageListener
    }

    private func handlerNode(for node: NavigationNode) -> NavigationNode? {
        node.nearestNodeWhichCanPresent
    }

}

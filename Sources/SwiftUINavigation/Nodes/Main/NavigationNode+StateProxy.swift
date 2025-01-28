public extension NavigationNode {
    var id: String {
        state.id
    }

    @MainActor
    var parent: (any NavigationNode)? {
        state.parent
    }

    @MainActor
    var presentedNode: (any PresentedNavigationNode)? {
        state.presentedNode
    }

    @MainActor
    var children: [any NavigationNode] {
        state.children
    }

    @MainActor
    func printDebugText(_ text: String) {
        state.printDebugText(text)
    }

    @MainActor
    func printDebugGraph() {
        root.state.printDebugGraphFromExactNode()
    }

    @MainActor
    func onMessageReceived(_ listener: NavigationMessageListener?) -> Self {
        state.addMessageListener(listener)
        return self
    }

    @MainActor
    func addMessageListener(_ listener: NavigationMessageListener?) {
        state.addMessageListener(listener)
    }

    @MainActor
    func sendMessage(_ message: NavigationMessage) {
        state.sendMessage(message)
    }

    @MainActor
    func sendEnvironmentTrigger(_ trigger: NavigationEnvironmentTrigger) {
        state.sendEnvironmentTrigger(trigger)
    }
}

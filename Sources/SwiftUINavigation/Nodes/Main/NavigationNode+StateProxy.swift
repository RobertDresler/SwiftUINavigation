@MainActor
public extension NavigationNode {
    var id: String {
        state.id
    }

    var parent: (any NavigationNode)? {
        state.parent
    }

    var presentedNode: (any PresentedNavigationNode)? {
        state.presentedNode
    }

    var children: [any NavigationNode] {
        state.children
    }

    func printDebugText(_ text: String) {
        state.printDebugText(text)
    }

    func printDebugGraph() {
        root.state.printDebugGraphFromExactNode()
    }

    func addMessageListener(_ listener: NavigationMessageListener?) {
        state.addMessageListener(listener)
    }

    func sendMessage(_ message: NavigationMessage) {
        state.sendMessage(message)
    }

    func sendEnvironmentTrigger(_ trigger: NavigationEnvironmentTrigger) {
        state.sendEnvironmentTrigger(trigger)
    }
}

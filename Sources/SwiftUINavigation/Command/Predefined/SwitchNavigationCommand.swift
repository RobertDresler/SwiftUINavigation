public struct SwitchNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        guard let state = node as? any SwitchedNavigationNode else { return }
        state.switchedNode = switchedNode
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node is any SwitchedNavigationNode
    }

    private let switchedNode: any NavigationNode

    public init(switchedNode: any NavigationNode) {
        self.switchedNode = switchedNode
    }

}

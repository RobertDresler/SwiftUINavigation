public struct SwitchNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        guard let state = node.state as? SwitchedNavigationNodeState else { return }
        state.switchedNode = switchedNode
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node.state is SwitchedNavigationNodeState
    }

    private let switchedNode: any NavigationNode

    public init(switchedNode: any NavigationNode) {
        self.switchedNode = switchedNode
    }

}

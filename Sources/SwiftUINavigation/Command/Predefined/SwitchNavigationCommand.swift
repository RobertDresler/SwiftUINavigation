public struct SwitchNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let node = node as? SwitchedNavigationNode else { return }
        node.switchedNode = switchedNode
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        node is SwitchedNavigationNode
    }

    private let switchedNode: NavigationNode

    public init(switchedNode: NavigationNode) {
        self.switchedNode = switchedNode
    }

}

public struct SwitchNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let node = node as? SwitchedNavigationNode else { return }
        node.switchedNode = switchedNode
    }

    private let switchedNode: NavigationNode

    public init(switchedNode: NavigationNode) {
        self.switchedNode = switchedNode
    }

}

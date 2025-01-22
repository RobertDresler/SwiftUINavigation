public struct DismissJustFromPresentedNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        guard canExecute(on: node) else { return }
        if node.state.presentedNode != nil {
            perform(
                animated: animated,
                action: { node.state.presentedNode = nil }
            )
        } else if let parent = node.parent {
            execute(on: parent)
        }
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains { predecessorIncludingSelf in
            guard let presentedNode = predecessorIncludingSelf.state.presentedNode else { return false }
            return node.predecessorsIncludingSelf.contains(where: { $0 === presentedNode.node })
        }
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

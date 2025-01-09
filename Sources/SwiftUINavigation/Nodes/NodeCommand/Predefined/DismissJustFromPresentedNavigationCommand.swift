public struct DismissJustFromPresentedNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard canExecute(on: node) else { return }
        if node.presentedNode != nil {
            perform(
                animated: animated,
                action: { node.presentedNode = nil }
            )
        } else if let parent = node.parent {
            execute(on: parent)
        }
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains { predecessorIncludingSelf in
            guard let presentedNode = predecessorIncludingSelf.presentedNode else { return false }
            return node.predecessorsIncludingSelf.contains(where: { $0 === presentedNode.node })
        }
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

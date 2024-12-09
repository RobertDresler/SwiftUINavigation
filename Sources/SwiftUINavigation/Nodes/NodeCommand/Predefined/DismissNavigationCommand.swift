public struct DismissNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        if node.presentedNode != nil {
            perform(
                animated: animated,
                action: { node.presentedNode = nil }
            )
        } else if let parent = node.parent {
            execute(on: parent)
        }
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

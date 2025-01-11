public struct DismissNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let nearestNodeWhichCanPresent = node.nearestNodeWhichCanPresent else { return }
        perform(
            animated: animated,
            action: { nearestNodeWhichCanPresent.parent?.presentedNode = nil }
        )
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        let nearestNodeWhichCanPresent = node.nearestNodeWhichCanPresent
        return nearestNodeWhichCanPresent?.parent?.presentedNode?.node === nearestNodeWhichCanPresent
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

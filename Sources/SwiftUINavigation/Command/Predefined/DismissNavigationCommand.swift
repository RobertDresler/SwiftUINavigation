public struct DismissNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        guard let nearestNodeWhichCanPresent = node.nearestNodeWhichCanPresent else { return }
        perform(
            animated: animated,
            action: { nearestNodeWhichCanPresent.parent?.state.presentedNode = nil }
        )
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        let nearestNodeWhichCanPresent = node.nearestNodeWhichCanPresent
        return nearestNodeWhichCanPresent?.parent?.state.presentedNode?.node === nearestNodeWhichCanPresent
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}

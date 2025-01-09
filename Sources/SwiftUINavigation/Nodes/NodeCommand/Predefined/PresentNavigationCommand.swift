public struct PresentNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        executableCommand(on: node)?.execute(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        executableCommand(on: node)?.canExecute(on: node) ?? false
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
    }

    private func executableCommand(on node: NavigationNode) -> NavigationCommand? {
        guard let presenterNode = nearestNodeWhichCanPresent(from: node) else { return nil }
        return PresentOnGivenNodeNavigationCommand(
            presentedNode: presentedNode,
            animated: animated
        )
    }

    private func nearestNodeWhichCanPresent(from node: NavigationNode) -> NavigationNode? {
        guard let nearestNodeWhichCanPresentFromParent = nearestNodeWhichCanPresentFromParent(from: node) else {
            return nil
        }
        return topPresented(from: nearestNodeWhichCanPresentFromParent)
    }

    func topPresented(from node: NavigationNode) -> NavigationNode {
        if let presentedNode = node.presentedNode?.node {
            return topPresented(from: presentedNode)
        } else {
            return node
        }
    }

    func nearestNodeWhichCanPresentFromParent(from node: NavigationNode) -> NavigationNode? {
        if node.canPresentIfWouldnt {
            node
        } else if let parent = node.parent {
            nearestNodeWhichCanPresentFromParent(from: parent)
        } else {
            nil
        }
    }

}

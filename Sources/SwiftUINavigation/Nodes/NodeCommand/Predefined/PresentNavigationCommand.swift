public struct PresentNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        guard let presenterNode = nearestNodeWhichCanPresent(from: node) else { return }
        PresentOnGivenNodeNavigationCommand(
            presentedNode: presentedNode,
            animated: animated
        ).execute(on: presenterNode)
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
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

import SwiftUI

public enum NavigationNodeCommand {
    case append(NavigationNodeWithStackTransition)
    case removeLast(count: Int = 1)
    case removeAll
    case alert(AlertConfig)
    case present(any PresentedNavigationNode)
    case presentOnExactNode(any PresentedNavigationNode)
    case dismiss
    case setRoot(NavigationNode, clear: Bool)
    case switchNode(NavigationNode)
    case openURL(URL)
}

public protocol NavigationCommand {
    func execute(on node: NavigationNode)
}

public extension NavigationCommand {
    func perform(animated: Bool, action: () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            action()
        }
    }
}

public struct StackMapNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        mapStackNodes(on: node)
    }

    private let animated: Bool
    private let transform: ([NavigationNodeWithStackTransition]) -> [NavigationNodeWithStackTransition]

    public init(
        animated: Bool,
        transform: @escaping ([NavigationNodeWithStackTransition]) -> [NavigationNodeWithStackTransition]
    ) {
        self.animated = animated
        self.transform = transform
    }

    private func mapStackNodes(on node: NavigationNode) {
        guard let node = node as? StackRootNavigationNode else {
            if let parent = node.parent {
                return mapStackNodes(on: parent)
            } else {
                return
            }
        }
        setMappedNodes(for: node)
    }

    private func setMappedNodes(for node: StackRootNavigationNode) {
        perform(
            animated: animated,
            action: {
                node.stackNodes = transform(node.stackNodes)
            }
        )
    }

}

public struct StackAppendNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                nodes + [appendedNode]
            }
        ).execute(on: node)
    }

    private let appendedNode: NavigationNodeWithStackTransition
    private let animated: Bool

    public init(appendedNode: NavigationNodeWithStackTransition, animated: Bool = true) {
        self.appendedNode = appendedNode
        self.animated = animated
    }

}

public struct StackDropLastNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                nodes.dropLast(k)
            }
        ).execute(on: node)
    }

    private let k: Int
    private let animated: Bool

    public init(k: Int = 1, animated: Bool = true) {
        self.k = k
        self.animated = animated
    }

}

public struct StackSetRootNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        StackMapNavigationCommand(
            animated: animated,
            transform: { nodes in
                let rootNodeWithStackTransition = NavigationNodeWithStackTransition(
                    destination: rootNode,
                    transition: nil
                )
                if clear || nodes.isEmpty {
                    return [rootNodeWithStackTransition]
                } else {
                    var newNodes = nodes
                    newNodes.removeFirst()
                    return [rootNodeWithStackTransition] + newNodes
                }
            }
        ).execute(on: node)
    }

    private let rootNode: NavigationNode
    private let clear: Bool
    private let animated: Bool

    public init(rootNode: NavigationNode, clear: Bool, animated: Bool = true) {
        self.rootNode = rootNode
        self.clear = clear
        self.animated = animated
    }

}

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

public struct PresentOnGivenNodeNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        perform(
            animated: animated,
            action: { node.presentedNode = presentedNode }
        )
    }

    private let presentedNode: any PresentedNavigationNode
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.animated = animated
    }

}


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


public struct ResolvedHideNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        if (node.parent as? StackRootNavigationNode)?.stackNodes.first?.destination === node {
            DismissNavigationCommand(animated: animated).execute(on: node)
        } else {
            StackDropLastNavigationCommand(animated: animated).execute(on: node)
        }
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

}


public struct OpenURLNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.urlToOpen.send(url)
    }

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

}

public struct DefaultHandleDeepLinkNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.defaultDeepLinkHandler?.handleDeepLink(deepLink, on: node)
    }

    private let deepLink: any NavigationDeepLink

    public init(deepLink: any NavigationDeepLink) {
        self.deepLink = deepLink
    }

}

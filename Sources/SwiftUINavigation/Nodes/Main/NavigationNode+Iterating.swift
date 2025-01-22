import SwiftUI
import Combine

public extension NavigationNode {
    var root: any NavigationNode {
        parent?.root ?? self
    }

    var predecessors: [any NavigationNode] {
        parent?.predecessorsIncludingSelf ?? []
    }

    var predecessorsIncludingSelf: [any NavigationNode] {
        (parent?.predecessorsIncludingSelf ?? []) + [self]
    }

    var successors: [any NavigationNode] {
        children.flatMap(\.successorsIncludingSelf)
    }

    var successorsIncludingSelf: [any NavigationNode] {
        [self] + children.flatMap(\.successorsIncludingSelf)
    }

    var canPresentIfWouldnt: Bool {
        parent == nil || parent?.isWrapperNode == false || parent?.presentedNode?.node === self
    }

    var nearestNodeWhichCanPresent: (any NavigationNode)? {
        nearestChildrenNodeWhichCanPresent ?? nearestNodeWhichCanPresentFromParent?.topPresented
    }

    var topPresented: any NavigationNode {
        if let presentedNode = presentedNode?.node {
            presentedNode.topPresented
        } else {
            self
        }
    }

    var nearestChildrenNodeWhichCanPresent: (any NavigationNode)? {
        let childrenNodesWhichCanPresent = childrenNodesWhichCanPresent
        return childrenNodesWhichCanPresent.compactMap { $0.presentedNode?.node }.first?.nearestChildrenNodeWhichCanPresent
            ?? childrenNodesWhichCanPresent.last
    }

    var nearestNodeWhichCanPresentFromParent: (any NavigationNode)? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    var childrenNodesWhichCanPresent: [any NavigationNode] {
        var nodes = [any NavigationNode]()
        if canPresentIfWouldnt {
            nodes.append(self)
        }
        nodes += children.flatMap { $0.childrenNodesWhichCanPresent }
        return nodes
    }
}

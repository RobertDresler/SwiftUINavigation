import SwiftUI

public struct NavigationWindow<Node: NavigationNode>: View {

    @ObservedObject private var rootNode: Node

    // MARK: Init

    public init(rootNode: Node, defaultDeepLinkHandler: NavigationDeepLinkHandler? = nil) {
        self.rootNode = rootNode
        Task { @MainActor in
            await rootNode.startIfNeeded(parent: nil, defaultDeepLinkHandler: defaultDeepLinkHandler)
        }
    }

    public var body: some View {
        NavigationNodeResolvedView(node: rootNode)
    }

}

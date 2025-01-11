import SwiftUI

public struct NavigationWindow: View {

    @ObservedObject private var rootNode: NavigationNode

    // MARK: Init

    public init(rootNode: NavigationNode, defaultDeepLinkHandler: NavigationDeepLinkHandler? = nil) {
        self.rootNode = rootNode
        rootNode.setDefaultDeepLinkHandler(defaultDeepLinkHandler)
    }

    public var body: some View {
        NavigationNodeResolvedView(node: rootNode)
    }

}

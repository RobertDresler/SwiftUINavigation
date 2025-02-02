import SwiftUI

public struct RootNavigationView<Node: NavigationNode>: View {

    @ObservedObject private var rootNode: Node

    // MARK: Init

    public init(rootNode: Node) {
        self.rootNode = rootNode
        Task { @MainActor in
            await rootNode.startIfNeeded(parent: nil)
        }
    }

    public var body: some View {
        NavigationNodeResolvedView(node: rootNode)
    }

}

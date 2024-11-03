import SwiftUI

public struct NavigationWindow: View {

    @ObservedObject private var rootNode: NavigationNode

    // MARK: Init

    public init(rootNode: NavigationNode) {
        self.rootNode = rootNode
    }

    public var body: some View {
        NavigationNodeResolvedView(node: rootNode)
    }

}

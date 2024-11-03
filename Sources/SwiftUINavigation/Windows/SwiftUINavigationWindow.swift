import SwiftUI

public struct SwiftUINavigationWindow: View {

    @ObservedObject private var rootNode: SwiftUINavigationNode

    // MARK: Init

    public init(rootNode: SwiftUINavigationNode) {
        self.rootNode = rootNode
    }

    public var body: some View {
        SwiftUINavigationResolvedView(node: rootNode)
    }

}

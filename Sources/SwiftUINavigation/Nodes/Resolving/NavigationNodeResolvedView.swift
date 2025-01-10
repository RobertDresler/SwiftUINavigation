import SwiftUI

struct NavigationNodeResolvedView: View {

    @ObservedObject private var node: NavigationNode
    @Environment(\.openURL) private var openURL

    init(node: NavigationNode) {
        self.node = node
    }

    var body: some View {
        node.view
            .presentingNavigationSource(id: nil)
            .onReceive(node.urlToOpen) { openURL($0) }
            .environmentObject(node)
    }

}

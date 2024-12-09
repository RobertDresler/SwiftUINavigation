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
            .onReceive(node.urlToOpen) { openURLAction($0) }
            .environmentObject(node)
    }

    private func openURLAction(_ url: URL?) {
        guard let url else { return }
        openURL(url)
    }

}

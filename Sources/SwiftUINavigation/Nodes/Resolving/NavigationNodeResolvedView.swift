import SwiftUI

struct NavigationNodeResolvedView: View {

    @ObservedObject private var node: NavigationNode
    @Environment(\.self) private var environment
    @Environment(\.navigationEnvironmentTriggerHandler) private var environmentTriggerHandler

    init(node: NavigationNode) {
        self.node = node
    }

    var body: some View {
        node.view
            .presentingNavigationSource(id: nil)
            .onReceive(node.navigationEnvironmentTrigger) { environmentTriggerHandler.handleTrigger($0, in: environment) }
            .environmentObject(node)
    }

}

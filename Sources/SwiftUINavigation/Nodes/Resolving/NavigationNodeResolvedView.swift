import SwiftUI

/// Use this `View` directly just when you do need to wrap some node as child to other node
public struct NavigationNodeResolvedView: View {

    @ObservedObject private var node: NavigationNode
    @Environment(\.self) private var environment
    @Environment(\.navigationEnvironmentTriggerHandler) private var environmentTriggerHandler

    public init(node: NavigationNode) {
        self.node = node
    }

    public var body: some View {
        node.view
            .presentingNavigationSource(id: nil)
            .onReceive(node.navigationEnvironmentTrigger) { environmentTriggerHandler.handleTrigger($0, in: environment) }
            .environmentObject(node)
    }

}

import SwiftUI

/// Use this `View` directly just when you do need to wrap some node as child to other node
public struct NavigationNodeResolvedView: View {

    @ObservedObject private var node: AnyNavigationNode
    @Environment(\.self) private var environment
    @Environment(\.navigationEnvironmentTriggerHandler) private var environmentTriggerHandler

    public init(node: any NavigationNode) {
        self.node = AnyNavigationNode(node)
    }

    public var body: some View {
        node.body
            .presentingNavigationSource(id: nil)
            .onReceive(node.state.navigationEnvironmentTrigger) { environmentTriggerHandler.handleTrigger($0, in: environment) }
            .environmentObject(node)
    }

}

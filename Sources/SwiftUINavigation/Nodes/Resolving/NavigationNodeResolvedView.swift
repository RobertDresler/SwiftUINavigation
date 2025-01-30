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
            .onChange(of: equatableNodeChildren) { [oldChildren = equatableNodeChildren] newChildren in
                bindSendingRemovalMessages(
                    newChildren: newChildren.compactMap(\.wrapped),
                    oldChildren: oldChildren.compactMap(\.wrapped)
                )
            }
            .onChange(of: equatableNodeChildren) { bindParentLogic(children: $0.compactMap(\.wrapped)) }
            .onAppear { bindParentLogic(children: equatableNodeChildren.compactMap(\.wrapped)) }
            .environmentObject(node)
    }

    private var equatableNodeChildren: [EquatableNavigationNode] {
        nodeChildren.map { EquatableNavigationNode(wrapped: $0) }
    }

    private var nodeChildren: [any NavigationNode] {
        node.children
    }

    private func bindSendingRemovalMessages(
        newChildren: [any NavigationNode],
        oldChildren: [any NavigationNode]
    ) {
        let removedChildren = oldChildren.filter { oldChild in
            !newChildren.contains(where: { oldChild === $0 })
        }
        removedChildren.forEach { child in
            child.successorsIncludingSelf.forEach { node in
                node.finishIfNeeded()
            }
        }
    }

    private func bindParentLogic(children: [any NavigationNode]) {
        children.forEach { child in
            Task { @MainActor in
                await child.startIfNeeded(parent: node.base, defaultDeepLinkHandler: nil)
            }
        }
    }

}

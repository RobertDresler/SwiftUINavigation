import SwiftUI

struct StackRootNavigationNodeView: View {

    @Namespace private var namespace
    @EnvironmentNavigationNode private var navigationNode: StackRootNavigationNode

    // MARK: Getters

    var body: some View {
        NavigationStack(path: path) {
            navigationStackResolvedRoot
        }.stackNavigationNamespace(namespace)
    }

    private var path: Binding<NavigationPath> {
        Binding(
            get: { navigationPath },
            set: { setNewPath($0) }
        )
    }

    private var navigationStackResolvedRoot: some View {
        Group {
            if let rootNode = navigationNode.stackNodes.first?.destination {
                NavigationNodeResolvedView(node: rootNode)
                    .connectingNavigationDestinationLogic(
                        nodeForNodeID: { node(for: $0) },
                        namespace: namespace
                    )
            }
        }
    }

    private func node(for nodeID: String) -> NavigationNode? {
        stackNodes.first(where: { node in
            nodeID == node.destination.id
        })?.destination
    }

    private var navigationPath: NavigationPath {
        var stackNodes = stackNodes
        guard !stackNodes.isEmpty else { return NavigationPath() }
        stackNodes.removeFirst() /// Because first is root
        return NavigationPath(
            stackNodes.compactMap { node in
                StackNavigationDestination(
                    nodeID: node.destination.id,
                    transition: node.transition
                )
            }
        )
    }

    private var stackNodes: [StackNavigationNode] {
        navigationNode.stackNodes
    }

    // MARK: Methods

    private func setNewPath(_ newPath: NavigationPath) {
        navigationNode.setNewPath(newPath)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic(
        nodeForNodeID: @escaping (String) -> NavigationNode?,
        namespace: Namespace.ID?
    ) -> some View {
        navigationDestination(for: StackNavigationDestination.self) { data in
            Group {
                if let node = nodeForNodeID(data.nodeID) {
                    NavigationNodeResolvedView(node: node)
                        .destinationWithNavigationTransition(transition: data.transition, namespace: namespace)
                }
            }
        }
    }

    func destinationWithNavigationTransition(
        transition: StackNavigationTransition?,
        namespace: Namespace.ID?
    ) -> some View {
        Group {
            if #available(iOS 18.0, *), let namespace {
                switch transition {
                case .zoom(let sourceID):
                    navigationTransition(.zoom(sourceID: sourceID, in: namespace))
                case nil:
                    self
                }
            } else {
                self
            }
        }
    }
}

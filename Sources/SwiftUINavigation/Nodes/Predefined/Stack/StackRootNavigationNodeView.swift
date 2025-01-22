import SwiftUI

public struct StackRootNavigationNodeView: View {

    @Namespace private var namespace
    @EnvironmentNavigationNodeState private var navigationNodeState: StackRootNavigationNodeState

    // MARK: Getters

    public init() {}

    public var body: some View {
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
            if let rootNode = navigationNodeState.stackNodes.first?.destination {
                NavigationNodeResolvedView(node: rootNode)
                    .connectingNavigationDestinationLogic(
                        nodeForNodeID: { node(for: $0) },
                        namespace: namespace
                    )
            }
        }
    }

    private func node(for nodeID: String) -> (any NavigationNode)? {
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
        navigationNodeState.stackNodes
    }

    // MARK: Methods

    private func setNewPath(_ newPath: NavigationPath) {
        navigationNodeState.setNewPath(newPath)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic(
        nodeForNodeID: @escaping (String) -> (any NavigationNode)?,
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

import SwiftUI

struct SwiftUINavigationStackNodeResolvedView: View {

    @EnvironmentObject private var node: SwiftUINavigationNode
    @Environment(\.wrappedNavigationStackNodeNamespace) private var wrappedNavigationStackNodeNamespace

    // MARK: Getters

    var body: some View {
        NavigationStack(path: path) {
            navigationStackResolvedRoot
        }
    }

    private var path: Binding<NavigationPath> {
        Binding(
            get: {
                guard var stackNodes = stackNodes, !stackNodes.isEmpty else { return NavigationPath() }
                stackNodes.removeFirst() /// Because first is root
                return NavigationPath(stackNodes.compactMap { $0.toStackDeepLink })
            },
            set: { [weak node] newPath in
                node?.mapStackNodes { nodes in
                    Array(nodes.prefix(newPath.count + 1))
                }
            }
        )
    }

    private var navigationStackResolvedRoot: some View {
        Group {
            if let rootNode = node.stackNodes?.first?.destination {
                SwiftUINavigationResolvedView(node: rootNode)
                    .connectingNavigationDestinationLogic(
                        nodeForNodeID: { node(for: $0) },
                        namespace: wrappedNavigationStackNodeNamespace
                    )
            }
        }
    }

    private func node(for nodeID: String) -> SwiftUINavigationNode? {
        guard let stackNodes else { return nil }
        return stackNodes.first(where: { node in
            nodeID == node.destination.id
        })?.destination
    }

    private var stackNodes: [SwiftUINavigationNodeWithStackTransition]? {
        node.stackNodes
    }
}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic(
        nodeForNodeID: @escaping (String) -> SwiftUINavigationNode?,
        namespace: Namespace.ID?
    ) -> some View {
        navigationDestination(for: StackDeepLink.self) { data in
            Group {
                if let node = nodeForNodeID(data.nodeID) {
                    SwiftUINavigationResolvedView(node: node)
                        .destinationWithNavigationTransition(transition: data.transition, namespace: namespace)
                }
            }
        }
    }

    func destinationWithNavigationTransition(
        transition: StackDeepLink.Transition?,
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

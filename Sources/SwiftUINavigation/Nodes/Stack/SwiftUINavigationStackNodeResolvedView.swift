import SwiftUI

struct SwiftUINavigationStackNodeResolvedView<
    Resolver: SwiftUINavigationDeepLinkResolver
>: View {

    @EnvironmentObject private var resolver: Resolver
    @EnvironmentObject private var node: SwiftUINavigationNode<Resolver.DeepLink>
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
                SwiftUINavigationResolvedView<Resolver>(node: rootNode)
                    .connectingNavigationDestinationLogic(
                        resolverType: Resolver.self,
                        nodeForDeepLinkInstanceID: { node(for: $0) },
                        namespace: wrappedNavigationStackNodeNamespace
                    )
            }
        }
    }

    private func node(for deepLinkInstanceID: String) -> SwiftUINavigationNode<Resolver.DeepLink>? {
        guard let stackNodes else { return nil }
        return stackNodes.first(where: { node in
            if case .deepLink(let deepLink) = node.destination.value {
                deepLink.instanceID == deepLinkInstanceID
            } else {
                false
            }
        })?.destination
    }

    private var stackNodes: [SwiftUINavigationNode<Resolver.DeepLink>.NodeStackDeepLink]? {
        node.stackNodes
    }
}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic<Resolver: SwiftUINavigationDeepLinkResolver>(
        resolverType: Resolver.Type,
        nodeForDeepLinkInstanceID: @escaping (String) -> SwiftUINavigationNode<Resolver.DeepLink>?,
        namespace: Namespace.ID?
    ) -> some View {
        navigationDestination(for: StackDeepLink<Resolver.DeepLink>.self) { data in
            Group {
                if let node = nodeForDeepLinkInstanceID(data.destination.instanceID) {
                    SwiftUINavigationResolvedView<Resolver>(node: node)
                        .destinationWithNavigationTransition(transition: data.transition, namespace: namespace)
                }
            }
        }
    }

    func destinationWithNavigationTransition<Destination: NavigationDeepLink>(
        transition: StackDeepLink<Destination>.Transition?,
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

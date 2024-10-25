import SwiftUI

struct SwiftUINavigationStack<
    Resolver: SwiftUINavigationDeepLinkResolver
>: View {

    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var resolver: Resolver
    @Namespace private var namespace
    @ObservedObject private var node: SwiftUINavigationGraphNode<Resolver.DeepLink>

    // MARK: Init

    init(node: SwiftUINavigationGraphNode<Resolver.DeepLink>) {
        self.node = node
    }

    // MARK: Getters

    var body: some View {
        NavigationStack(path: path) {
            navigationStackResolvedRoot
        }
            .connectingSheetLogic(pathHolder: node, resolverType: Resolver.self)
            .connectingAlertLogic(pathHolder: node)
            .environmentObject(node)
            .wrappedCustomNavigationStackNamespace(namespace)
            .onAppear {
                node.setOpenURL({ openURL($0) })
            }
    }

    private var path: Binding<NavigationPath> {
        Binding(
            get: {
                guard var stackNodes = stackNodes, !stackNodes.isEmpty else { return NavigationPath() }
                stackNodes.removeFirst() /// Because first is root
                return NavigationPath(stackNodes.compactMap { $0.toStackDeepLink })
            },
            set: { newPath in
                node.mapStackNodes { nodes in
                    Array(nodes.prefix(newPath.count + 1))
                }
            }
        )
    }

    private var navigationStackResolvedRoot: some View {
        Group {
            if let rootNode = node.stackNodes?.first?.destination {
                resolvedStackNode(resolver: resolver, node: rootNode)
                    .connectingNavigationDestinationLogic(
                        resolver: resolver,
                        nodeForDeepLinkInstanceID: { node(for: $0) },
                        namespace: namespace
                    )
            }
        }
    }

    private func node(for deepLinkInstanceID: String) -> SwiftUINavigationGraphNode<Resolver.DeepLink>? {
        guard let stackNodes else { return nil }
        return stackNodes.first(where: { $0.destination.wrappedDeepLink?.instanceID == deepLinkInstanceID })?.destination
    }

    private var stackNodes: [SwiftUINavigationGraphNode<Resolver.DeepLink>.NodeStackDeepLink]? {
        node.stackNodes
    }
}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic<Resolver: SwiftUINavigationDeepLinkResolver>(
        resolver: Resolver,
        nodeForDeepLinkInstanceID: @escaping (String) -> SwiftUINavigationGraphNode<Resolver.DeepLink>?,
        namespace: Namespace.ID
    ) -> some View {
        navigationDestination(for: StackDeepLink<Resolver.DeepLink>.self) { data in
            Group {
                if let node = nodeForDeepLinkInstanceID(data.destination.instanceID) {
                    resolvedStackNode(resolver: resolver, node: node)
                        .destinationWithNavigationTransition(transition: data.transition, namespace: namespace)
                }
            }
        }
    }

    func resolvedStackNode<Resolver: SwiftUINavigationDeepLinkResolver>(
        resolver: Resolver,
        node: SwiftUINavigationGraphNode<Resolver.DeepLink>
    ) -> some View {
        Group {
            if let deepLink = node.wrappedDeepLink {
                resolver.resolve(deepLink)
                    .environmentObject(node)
            }
        }
    }

    func destinationWithNavigationTransition<Destination: NavigationDeepLink>(
        transition: StackDeepLink<Destination>.Transition?,
        namespace: Namespace.ID
    ) -> some View {
        Group {
            if #available(iOS 18.0, *) {
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

    func connectingSheetLogic<Resolver: SwiftUINavigationDeepLinkResolver>(
        pathHolder: SwiftUINavigationGraphNode<Resolver.DeepLink>,
        resolverType: Resolver.Type
    ) -> some View {
        sheet(
            isPresented: Binding(
                get: {
                    pathHolder.presentedSheetNode != nil
                },
                set: { isPresented in
                    guard !isPresented else { return }
                    pathHolder.presentedSheetNode = nil
                }
            ),
            content: {
                if let presentedSheetNode = pathHolder.presentedSheetNode {
                    SwiftUINavigationStack<Resolver>(node: presentedSheetNode)
                }
            }
        )
    }

    func connectingAlertLogic<Destination: NavigationDeepLink>(
        pathHolder: SwiftUINavigationGraphNode<Destination>
    ) -> some View {
        alert(
            Text(pathHolder.alertConfig?.title ?? ""),
            isPresented: Binding(
                get: { pathHolder.alertConfig != nil },
                set: { isPresented in
                    guard !isPresented else { return }
                    pathHolder.alertConfig = nil
                }
            ),
            actions: {
                ForEach(Array((pathHolder.alertConfig?.actions ?? []).enumerated()), id: \.offset) { enumeration in
                    Button(role: enumeration.element.role, action: enumeration.element.handler) {
                        Text(enumeration.element.title)
                    }
                }
            },
            message: { Text(pathHolder.alertConfig?.message ?? "") }
        )
    }
}

// MARK: Preview

enum CustomNavigationStackPreviewDeepLink: NavigationDeepLink {
    case text1
    case text2

    var instanceID: String {
        switch self {
        case .text1:
            "text1"
        case .text2:
            "text2"
        }
    }
}

struct CustomNavigationStackPreviewRootView: View {

    @EnvironmentObject private var pathHolder: SwiftUINavigationGraphNode<CustomNavigationStackPreviewDeepLink>

    var body: some View {
        VStack {
            Button("to text1") {
                pathHolder.append(StackDeepLink(destination: .text1, transition: nil))
            }
            Button("to text2") {
                pathHolder.append(StackDeepLink(destination: .text2, transition: nil))
            }
        }
    }

}

struct CustomNavigationStackPreviewDestinationView: View {

    @EnvironmentObject private var pathHolder: SwiftUINavigationGraphNode<CustomNavigationStackPreviewDeepLink>

    var text: String

    var body: some View {
        VStack {
            Text("I'm \(text)")
            Button("Back") {
                pathHolder.removeLast()
            }
        }
    }

}

final class CustomNavigationResolver: SwiftUINavigationDeepLinkResolver {

    func resolve(_ deepLink: CustomNavigationStackPreviewDeepLink) -> some View {
        Group {
            switch deepLink {
            case .text1:
                CustomNavigationStackPreviewDestinationView(text: "text1")
            case .text2:
                CustomNavigationStackPreviewDestinationView(text: "text2")
            }
        }
    }

}

/*#Preview {
    SwiftUINavigationWindow(
        root: CustomNavigationStackPreviewDeepLink.text1,
        resolver: CustomNavigationResolver()
    )
}
*/

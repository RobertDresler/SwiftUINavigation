import SwiftUI

struct SwiftUINavigationResolvedView<Resolver: SwiftUINavigationDeepLinkResolver>: View {

    @EnvironmentObject private var resolver: Resolver
    @ObservedObject private var node: SwiftUINavigationNode<Resolver.DeepLink>
    @Environment(\.openURL) private var openURL
    @Namespace private var namespace

    init(node: SwiftUINavigationNode<Resolver.DeepLink>) {
        self.node = node
    }

    var body: some View {
        resolvedValueView
            .connectingSheetLogic(node: node, resolverType: Resolver.self)
           // .connectingAlertLogic(pathHolder: node)
            .wrappedNavigationStackNodeNamespace(node.type == .stackRoot ? namespace : nil)
            .onReceive(node.urlToOpen) { openURLAction($0) }
            .environmentObject(node)
    }

    var resolvedValueView: some View {
        Group { [weak node] in
            switch node?.value {
            case .deepLink(let deepLink):
                resolver.resolve(deepLink)
            case .stackRoot:
                SwiftUINavigationStackNodeResolvedView<Resolver>()
            case .none:
                EmptyView()
            }
        }
    }

    func openURLAction(_ url: URL?) {
        guard let url else { return }
        openURL(url)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingSheetLogic<Resolver: SwiftUINavigationDeepLinkResolver>(
        node: SwiftUINavigationNode<Resolver.DeepLink>,
        resolverType: Resolver.Type
    ) -> some View {
        sheet(
            isPresented: Binding(
                get: { [weak node] in
                    node?.presentedSheetNode != nil
                },
                set: { [weak node] isPresented in
                    guard !isPresented else { return }
                    node?.presentedSheetNode = nil
                }
            ),
            content: { [weak node] in
                if let presentedSheetNode = node?.presentedSheetNode {
                    SwiftUINavigationResolvedView<Resolver>(node: presentedSheetNode)
                }
            }
        )
    }

    func connectingAlertLogic<Destination: NavigationDeepLink>(
        pathHolder: SwiftUINavigationNode<Destination>
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

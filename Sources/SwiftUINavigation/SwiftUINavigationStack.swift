import SwiftUI

public struct SwiftUINavigationStack<
    Destination: NavigationDeepLink,
    Resolver: SwiftUINavigationDeepLinkResolver
>: View where Resolver.DeepLink == Destination {

    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var resolver: Resolver
    @Namespace private var namespace
    @ObservedObject private var pathHolder: CustomNavigationStackPathHolder<Destination>

    // MARK: Init

    public init(root: Destination) {
        self.init(
            pathHolder: CustomNavigationStackPathHolder(root: root, parent: nil)
        )
    }

    fileprivate init(pathHolder: CustomNavigationStackPathHolder<Destination>) {
        self.pathHolder = pathHolder
    }

    // MARK: Getters

    public var body: some View {
        NavigationStack(path: $pathHolder.path) {
            navigationStackResolvedRoot
        }
            .environmentObject(pathHolder)
            .wrappedCustomNavigationStackNamespace(namespace)
            .onAppear {
                pathHolder.setOpenURL({ openURL($0) })
            }
    }

    private var navigationStackResolvedRoot: some View {
        resolver.resolve(pathHolder.root)
            .connectingNavigationDestinationLogic(resolver: resolver, namespace: namespace)
            .connectingSheetLogic(pathHolder: pathHolder, destinationType: Destination.self, resolverType: Resolver.self)
            .connectingAlertLogic(pathHolder: pathHolder)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic<
        Destination: NavigationDeepLink,
        Resolver: SwiftUINavigationDeepLinkResolver
    >(
        resolver: Resolver,
        namespace: Namespace.ID
    ) -> some View where Resolver.DeepLink == Destination {
        navigationDestination(for: AppendDestination<Destination>.self) { data in
            resolver.resolve(data.destination)
                .destinationWithNavigationTransition(transition: data.transition, namespace: namespace)
        }
    }

    func destinationWithNavigationTransition<Destination: NavigationDeepLink>(
        transition: AppendDestination<Destination>.Transition?,
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

    func connectingSheetLogic<
        Destination: NavigationDeepLink,
        Resolver: SwiftUINavigationDeepLinkResolver
    >(
        pathHolder: CustomNavigationStackPathHolder<Destination>,
        destinationType: Destination.Type,
        resolverType: Resolver.Type
    ) -> some View where Resolver.DeepLink == Destination {
        sheet(
            isPresented: Binding(
                get: { pathHolder.presentedSheetDestination != nil },
                set: { isPresented in
                    guard !isPresented else { return }
                    pathHolder.presentedSheetDestination = nil
                }
            ),
            content: {
                if let presentedSheetDestination = pathHolder.presentedSheetDestination {
                    SwiftUINavigationStack<Destination, Resolver>(
                        pathHolder: CustomNavigationStackPathHolder(
                            root: presentedSheetDestination,
                            parent: pathHolder
                        )
                    )
                }
            }
        )
    }

    func connectingAlertLogic<Destination: NavigationDeepLink>(
        pathHolder: CustomNavigationStackPathHolder<Destination>
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
}

struct CustomNavigationStackPreviewRootView: View {

    @EnvironmentObject private var pathHolder: CustomNavigationStackPathHolder<CustomNavigationStackPreviewDeepLink>

    var body: some View {
        VStack {
            Button("to text1") {
                pathHolder.append(AppendDestination(destination: .text1, transition: nil))
            }
            Button("to text2") {
                pathHolder.append(AppendDestination(destination: .text2, transition: nil))
            }
        }
    }

}

struct CustomNavigationStackPreviewDestinationView: View {

    @EnvironmentObject private var pathHolder: CustomNavigationStackPathHolder<CustomNavigationStackPreviewDeepLink>

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

#Preview {
    SwiftUINavigationWindow(
        root: CustomNavigationStackPreviewDeepLink.text1,
        resolver: CustomNavigationResolver()
    )
}

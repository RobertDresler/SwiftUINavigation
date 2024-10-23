import SwiftUI

public struct CustomNavigationStack<
    Destination: NavigationDeepLink,
    DestinationView: View
>: View {

    @Environment(\.openURL) private var openURL
    @Namespace private var namespace
    @ObservedObject private var pathHolder: CustomNavigationStackPathHolder<Destination>
    @ViewBuilder private var resolvedDestination: (Destination) -> DestinationView

    // MARK: Init

    public init(
        root: Destination,
        @ViewBuilder resolvedDestination: @escaping (Destination) -> DestinationView
    ) {
        self.init(
            pathHolder: CustomNavigationStackPathHolder(root: root, parent: nil),
            resolvedDestination: resolvedDestination
        )
    }

    fileprivate init(
        pathHolder: CustomNavigationStackPathHolder<Destination>,
        @ViewBuilder resolvedDestination: @escaping (Destination) -> DestinationView
    ) {
        self.pathHolder = pathHolder
        self.resolvedDestination = resolvedDestination
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
        resolvedDestination(pathHolder.root)
            .connectingNavigationDestinationLogic(resolvedDestination: resolvedDestination, namespace: namespace)
            .connectingSheetLogic(pathHolder: pathHolder, resolvedDestination: resolvedDestination)
            .connectingAlertLogic(pathHolder: pathHolder)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic<Destination: NavigationDeepLink, DestinationView: View>(
        resolvedDestination: @escaping (Destination) -> DestinationView,
        namespace: Namespace.ID
    ) -> some View {
        navigationDestination(for: AppendDestination<Destination>.self) { data in
            resolvedDestination(data.destination)
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

    func connectingSheetLogic<Destination: NavigationDeepLink, DestinationView: View>(
        pathHolder: CustomNavigationStackPathHolder<Destination>,
        resolvedDestination: @escaping (Destination) -> DestinationView
    ) -> some View {
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
                    CustomNavigationStack<Destination, DestinationView>(
                        pathHolder: CustomNavigationStackPathHolder(
                            root: presentedSheetDestination,
                            parent: pathHolder
                        ),
                        resolvedDestination: resolvedDestination
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

#Preview {
    CustomNavigationStack(
        root: CustomNavigationStackPreviewDeepLink.text1,
        resolvedDestination: { (deepLink: CustomNavigationStackPreviewDeepLink) in
            Group {
                switch deepLink {
                case .text1:
                    CustomNavigationStackPreviewDestinationView(text: "text1")
                case .text2:
                    CustomNavigationStackPreviewDestinationView(text: "text2")
                }
            }
        }
    )
}

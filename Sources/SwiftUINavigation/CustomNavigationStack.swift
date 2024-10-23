import SwiftUI

public struct CustomNavigationStack<
    Destination: NavigationDeepLink,
    DestinationView: View
>: View {

    @Environment(\.openURL) private var openURL
    @StateObject private var pathHolder = CustomNavigationStackPathHolder<Destination>()
    private var root: Destination
    @ViewBuilder private var resolvedDestination: (Destination) -> DestinationView
    private let parentPathHolder: CustomNavigationStackPathHolder<Destination>?

    public init(
        parentPathHolder: CustomNavigationStackPathHolder<Destination>? = nil,
        root: Destination,
        @ViewBuilder resolvedDestination: @escaping (Destination) -> DestinationView
    ) {
        self.parentPathHolder = parentPathHolder
        self.root = root
        self.resolvedDestination = resolvedDestination
    }

    public var body: some View {
        NavigationStack(path: $pathHolder.path) {
            navigationStackResolvedRoot
        }
            .environmentObject(pathHolder)
            .onAppear {
                pathHolder.setParentPathHolder(parentPathHolder: parentPathHolder)
                pathHolder.setOpenURL({ openURL($0) })
            }
    }

    private var navigationStackResolvedRoot: some View {
        resolvedDestination(root)
            .connectingNavigationDestinationLogic(resolvedDestination: resolvedDestination)
            .connectingSheetLogic(pathHolder: pathHolder, resolvedDestination: resolvedDestination)
            .connectingAlertLogic(pathHolder: pathHolder)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic<Destination: NavigationDeepLink, DestinationView: View>(
        resolvedDestination: @escaping (Destination) -> DestinationView
    ) -> some View {
        navigationDestination(for: Destination.self) { data in
            resolvedDestination(data)
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
                        parentPathHolder: pathHolder,
                        root: presentedSheetDestination,
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
                pathHolder.append(.text1)
            }
            Button("to text2") {
                pathHolder.append(.text2)
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

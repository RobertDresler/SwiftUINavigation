import SwiftUI

struct SwiftUINavigationResolvedView: View {

    //@EnvironmentObject private var resolver: Resolver
    @ObservedObject private var node: SwiftUINavigationNode
    @Environment(\.openURL) private var openURL
    @Namespace private var namespace

    init(node: SwiftUINavigationNode) {
        self.node = node
    }

    var body: some View {
        node.view
            .connectingSheetLogic(node: node)
           // .connectingAlertLogic(pathHolder: node)
            .onReceive(node.urlToOpen) { openURLAction($0) }
            .environmentObject(node)
    }

    private func openURLAction(_ url: URL?) {
        guard let url else { return }
        openURL(url)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingSheetLogic(node: SwiftUINavigationNode) -> some View {
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
                    SwiftUINavigationResolvedView(node: presentedSheetNode)
                }
            }
        )
    }

    /*func connectingAlertLogic(
        pathHolder: SwiftUINavigationNode
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
    }*/
}

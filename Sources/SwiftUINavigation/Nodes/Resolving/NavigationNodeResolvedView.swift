import SwiftUI

struct NavigationNodeResolvedView: View {

    @ObservedObject private var node: NavigationNode
    @Environment(\.openURL) private var openURL

    init(node: NavigationNode) {
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
    func connectingSheetLogic(node: NavigationNode) -> some View {
        sheet(
            isPresented: Binding(
                get: {
                    node.presentedSheetNode != nil
                },
                set: { isPresented in
                    guard !isPresented else { return }
                    node.presentedSheetNode = nil
                }
            ),
            content: {
                if let presentedSheetNode = node.presentedSheetNode {
                    NavigationNodeResolvedView(node: presentedSheetNode)
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

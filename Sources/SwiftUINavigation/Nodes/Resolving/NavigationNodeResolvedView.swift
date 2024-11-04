import SwiftUI

struct NavigationNodeResolvedView: View {

    @ObservedObject private var node: NavigationNode
    @Environment(\.openURL) private var openURL

    init(node: NavigationNode) {
        self.node = node
    }

    var body: some View {
        node.view
            .connectingFullScreenCoverLogic(node: node)
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
    func connectingFullScreenCoverLogic(node: NavigationNode) -> some View {
        fullScreenCover(
            isPresented: Binding(
                get: {
                    if case .fullScreenCover = node.presentedNode?.style {
                        true
                    } else {
                        false
                    }
                },
                set: { isPresented in
                    guard !isPresented else { return }
                    node.presentedNode = nil
                }
            ),
            content: {
                if let node = node.presentedNode, case .fullScreenCover = node.style {
                    NavigationNodeResolvedView(node: node.node)
                }
            }
        )
    }

    func connectingSheetLogic(node: NavigationNode) -> some View {
        sheet(
            isPresented: Binding(
                get: {
                    if case .sheet = node.presentedNode?.style {
                        true
                    } else {
                        false
                    }
                },
                set: { isPresented in
                    guard !isPresented else { return }
                    node.presentedNode = nil
                }
            ),
            content: {
                if let node = node.presentedNode, case .sheet(let detents) = node.style {
                    NavigationNodeResolvedView(node: node.node)
                        .presentationDetents(detents)
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

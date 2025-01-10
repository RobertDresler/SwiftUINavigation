import SwiftUI

public final class AlertPresentedNavigationNode: PresentedNavigationNode {

    public let node: NavigationNode

    public init(inputData: AlertInputData, sourceID: String? = nil) {
        self.node = AlertNavigationNode(inputData: inputData, sourceID: sourceID)
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        id: String?
    ) -> some View {
        content
            .alert(
                title(for: presentedNode?.node),
                isPresented: makeIsPresentedBinding(
                    presentedNode: presentedNode,
                    additionalCheck: { (node: AlertNavigationNode) in node.sourceID == id }
                ),
                actions: { actions(for: presentedNode?.node) },
                message: { message(for: presentedNode?.node) }
            )
    }

    private static func title(for node: NavigationNode?) -> Text {
        Text((node as? AlertNavigationNode)?.inputData.title ?? "")
    }

    private static func actions(for node: NavigationNode?) -> some View {
        Group {
            if let node = node as? AlertNavigationNode {
                ForEach((node as? AlertNavigationNode)?.inputData.actions ?? [], id: \.id) { action in
                    Button(
                        action.title,
                        role: {
                            switch action.role {
                            case .cancel:
                                .cancel
                            case .destructive:
                                .destructive
                            case .none:
                                .none
                            }
                        }(),
                        action: { action.handler?() }
                    )
                }
            }
        }
    }

    private static func message(for node: NavigationNode?) -> some View {
        Group {
            if let message = (node as? AlertNavigationNode)?.inputData.message {
                Text(message)
            }
        }
    }

}

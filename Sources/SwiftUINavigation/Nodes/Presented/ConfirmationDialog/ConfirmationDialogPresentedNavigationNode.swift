import SwiftUI

public final class ConfirmationDialogPresentedNavigationNode: PresentedNavigationNode {

    public let node: NavigationNode

    public init(inputData: ConfirmationDialogInputData, sourceID: String? = nil) {
        self.node = ConfirmationDialogNavigationNode(inputData: inputData, sourceID: sourceID)
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        id: String?
    ) -> some View {
        content
            .confirmationDialog(
                Text(""),
                isPresented: makeIsPresentedBinding(
                    presentedNode: presentedNode,
                    additionalCheck: { (node: ConfirmationDialogNavigationNode) in node.sourceID == id }
                ),
                actions: { actions(for: presentedNode?.node) },
                message: { message(for: presentedNode?.node) }
            )
    }

    private static func actions(for node: NavigationNode?) -> some View {
        Group {
            if let node = node as? ConfirmationDialogNavigationNode {
                ForEach((node as? ConfirmationDialogNavigationNode)?.inputData.actions ?? [], id: \.id) { action in
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
            if let message = (node as? ConfirmationDialogNavigationNode)?.inputData.message {
                Text(message)
            }
        }
    }

}

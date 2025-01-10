import SwiftUI

public final class ConfirmationDialogPresentedNavigationNode: PresentedNavigationNode {

    public let node: NavigationNode
    public let sourceID: String?

    public init(inputData: ConfirmationDialogInputData, sourceID: String? = nil) {
        self.node = ConfirmationDialogNavigationNode(inputData: inputData)
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedNode: (any PresentedNavigationNode)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .confirmationDialog(
                Text(""),
                isPresented: makeIsPresentedBinding(presentedNode: presentedNode, sourceID: sourceID),
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

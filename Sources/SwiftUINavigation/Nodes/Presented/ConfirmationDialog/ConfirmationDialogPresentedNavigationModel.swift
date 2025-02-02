import SwiftUI

public struct ConfirmationDialogPresentedNavigationModel: PresentedNavigationModel {

    public let model: any NavigationModel
    public let sourceID: String?

    public init(inputData: ConfirmationDialogInputData, sourceID: String? = nil) {
        self.model = ConfirmationDialogNavigationModel(inputData: inputData)
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .confirmationDialog(
                Text(""),
                isPresented: makeIsPresentedBinding(presentedModel: presentedModel, sourceID: sourceID),
                actions: { actions(for: presentedModel?.model) },
                message: { message(for: presentedModel?.model) }
            )
    }

    private static func actions(for model: (any NavigationModel)?) -> some View {
        Group {
            if let model = model as? ConfirmationDialogNavigationModel {
                ForEach((model as? ConfirmationDialogNavigationModel)?.inputData.actions ?? [], id: \.id) { action in
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

    private static func message(for model: (any NavigationModel)?) -> some View {
        Group {
            if let message = (model as? ConfirmationDialogNavigationModel)?.inputData.message {
                Text(message)
            }
        }
    }

}

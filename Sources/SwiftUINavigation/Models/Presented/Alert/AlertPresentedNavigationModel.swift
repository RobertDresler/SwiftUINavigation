import SwiftUI

public struct AlertPresentedNavigationModel: PresentedNavigationModel {

    public let model: any NavigationModel
    public let sourceID: String?

    public init(inputData: AlertInputData, sourceID: String? = nil) {
        self.model = AlertNavigationModel(inputData: inputData)
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .alert(
                title(for: presentedModel?.model),
                isPresented: makeIsPresentedBinding(presentedModel: presentedModel, sourceID: sourceID),
                actions: { actions(for: presentedModel?.model) },
                message: { message(for: presentedModel?.model) }
            )
    }

    private static func title(for model: (any NavigationModel)?) -> Text {
        Text((model as? AlertNavigationModel)?.inputData.title ?? "")
    }

    private static func actions(for model: (any NavigationModel)?) -> some View {
        Group {
            if let model = model as? AlertNavigationModel {
                ForEach((model as? AlertNavigationModel)?.inputData.actions ?? [], id: \.id) { action in
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
            if let message = (model as? AlertNavigationModel)?.inputData.message {
                Text(message)
            }
        }
    }

}

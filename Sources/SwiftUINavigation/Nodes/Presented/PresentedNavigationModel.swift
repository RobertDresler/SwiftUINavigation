import SwiftUI

@MainActor
public protocol PresentedNavigationModel {
    associatedtype Body: View
    var model: any NavigationModel { get }
    var sourceID: String? { get }
    static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> Body
}

public extension PresentedNavigationModel {
    static func makeIsPresentedBinding(
        presentedModel: (any PresentedNavigationModel)?,
        sourceID: String?
    ) -> Binding<Bool> {
        Binding(
            get: {
                if let presentedModel = presentedModel as? Self,
                presentedModel.sourceID == sourceID {
                    true
                } else {
                    false
                }
            },
            set: { isPresented in
                guard !isPresented else { return }
                presentedModel?.model.parent?.presentedModel = nil
            }
        )
    }
}

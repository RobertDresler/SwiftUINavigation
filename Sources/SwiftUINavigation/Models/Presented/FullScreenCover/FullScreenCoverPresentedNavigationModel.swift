import SwiftUI

#if os(iOS)
public struct FullScreenCoverPresentedNavigationModel: PresentedNavigationModel {

    public let model: any NavigationModel
    public let sourceID: String? = nil
    public let transition: AnyTransition?

    init(model: any NavigationModel, transition: AnyTransition?) {
        self.model = model
        if #available(iOS 17.0, *) {
            self.transition = transition
        } else {
            self.transition = nil
        }
    }

    public static func presenterResolvedViewModifier(
        presentedModel: (any PresentedNavigationModel)?,
        content: AnyView,
        sourceID: String?
    ) -> some View {
        content
            .fullScreenCover(
                isPresented: makeIsPresentedBinding(presentedModel: presentedModel, sourceID: sourceID),
                content: {
                    if let presentedModel = presentedModel as? Self {
                        if #available(iOS 17.0, *), let transition = presentedModel.transition {
                            FullScreenCoverWithTransitionContentView(
                                transition: transition,
                                content: {
                                    NavigationModelResolvedView(model: presentedModel.model)
                                }
                            )
                        } else {
                            NavigationModelResolvedView(model: presentedModel.model)
                        }
                    }
                }
            )
    }

    @available(iOS 17.0, *)
    struct FullScreenCoverWithTransitionContentView<Content: View>: View {

        @Environment(\.dismiss) var dismiss
        @State private var isVisible = false

        var transition: AnyTransition
        @ViewBuilder var content: () -> Content

        var body: some View {
            ZStack {
                Color.clear
                resolvedContent
            }
                .onAppear { isVisible = true }
                .onDisappear { isVisible = false }
                .presentationBackground(.clear)
                .customDismiss {
                    withAnimation {
                        isVisible = false
                    } completion: {
                        dismiss()
                    }
                }
        }

        @ViewBuilder
        private var resolvedContent: some View {
            if isVisible {
                content()
                    .transition(transition)
            }
        }

    }

}
#endif

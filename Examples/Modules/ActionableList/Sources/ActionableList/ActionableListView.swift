import SwiftUI
import ExamplesNavigation
import SwiftUINavigation
import Shared
import FlagsRepository
import NotificationsService
import DeepLinkForwarderService

struct ActionableListView: View {

    @EnvironmentNavigationModel private var navigationModel: ActionableListNavigationModel
    @Environment(\.stackNavigationNamespace) private var wrappedNavigationStackModelNamespace
    @ObservedObject private var model: ActionableListModel

    init(model: ActionableListModel) {
        self.model = model
    }

    var body: some View {
        scrollView
            .navigationTitle(model.title)
            .toolbar {
                if navigationModel.canDismiss {
                    ToolbarItem(placement: .topBarTrailing) {
                        dismissButton
                    }
                }
            }
            .presentationDetents(model.inputData.addPresentationDetents ? [.medium, .large] : [])
    }

    private var dismissButton: some View {
        DismissButton(action: { navigationModel.dismiss() })
    }

    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let subtitle = model.subtitle {
                    self.subtitle(for: subtitle)
                }
                itemsView
            }
                .padding()
        }.background(SharedColor.backgroundGray)
    }

    private func subtitle(for subtitle: String) -> some View {
        Text(subtitle)
            .font(.system(size: 16))
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
    }

    private var itemsView: some View {
        VStack(spacing: 8) {
            ForEach(model.items, id: \.identifiableViewModel.id) { item in
                if #available(iOS 18.0, *), let wrappedNavigationStackModelNamespace {
                    configuredItemViewWithPresentingNavigationSource(for: item)
                        .matchedTransitionSource(
                            id: item.identifiableViewModel.id,
                            in: wrappedNavigationStackModelNamespace
                        )
                } else {
                    configuredItemViewWithPresentingNavigationSource(for: item)
                }
            }
        }
    }

    private func configuredItemViewWithPresentingNavigationSource(
        for item: ActionableListItem
    ) -> some View {
        Group {
            if let presentingNavigationSourceID = item.presentingNavigationSourceID {
                configuredItemView(for: item.identifiableViewModel)
                    .presentingNavigationSource(id: presentingNavigationSourceID)
            } else {
                configuredItemView(for: item.identifiableViewModel)
            }
        }
    }

    private func configuredItemView(
        for item: IdentifiableViewModel<String, ActionableListItemView.ViewModel>
    ) -> some View {
        ActionableListItemView(
            viewModel: item.viewModel,
            action: { model.handleAction(for: item.id) }
        )
    }

    // MARK: Actions

}

#Preview {
    ActionableListNavigationModel(
        inputData: .default,
        deepLinkForwarderService: DeepLinkForwarderService(),
        notificationsService: NotificationsService(notificationCenter: .current()),
        flagsRepository: FlagsRepository()
    ).body
}

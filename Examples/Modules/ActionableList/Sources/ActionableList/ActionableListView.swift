import SwiftUI
import SwiftUINavigation
import Shared

struct ActionableListView: View {

    @EnvironmentNavigationModel private var navigationModel: ActionableListNavigationModel
    @Environment(\.stackNavigationNamespace) private var wrappedNavigationStackModelNamespace
    @ObservedObject private var viewModel: ActionableListViewModel

    init(viewModel: ActionableListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        scrollView
            .navigationTitle(viewModel.title)
            .toolbar {
                if navigationModel.canDismiss {
                    ToolbarItem(placement: .topBarTrailing) {
                        dismissButton
                    }
                }
            }
            .presentationDetents(viewModel.inputData.addPresentationDetents ? [.medium, .large] : [])
    }

    private var dismissButton: some View {
        DismissButton(action: { navigationModel.dismiss() })
    }

    private var scrollView: some View {
        ScrollView {
            VStack(spacing: 24) {
                if let subtitle = viewModel.subtitle {
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
            ForEach(viewModel.items, id: \.identifiableViewModel.id) { item in
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
            action: { viewModel.handleAction(for: item.id) }
        )
    }

}

#Preview {
    ActionableListNavigationModel(
        inputData: .default,
        deepLinkForwarderService: DeepLinkForwarderService(),
        notificationsService: NotificationsService(notificationCenter: .current()),
        flagsRepository: FlagsRepository()
    ).body
}

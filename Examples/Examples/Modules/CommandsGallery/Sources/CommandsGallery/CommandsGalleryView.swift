import SwiftUI
import ExamplesNavigation
import SwiftUINavigation
import Shared

struct CommandsGalleryView: View {

    @EnvironmentNavigationNode private var navigationNode: CommandsGalleryNavigationNode
    @Environment(\.stackNavigationNamespace) private var wrappedNavigationStackNodeNamespace
    var inputData: CommandsGalleryInputData
    let title: String
    let items: [CommandsGalleryItem]

    init(inputData: CommandsGalleryInputData) {
        self.inputData = inputData
        let factory: CommandsGalleryDataFactory = {
            switch inputData.id {
            case .home:
                HomeCommandsGalleryDataFactory()
            case .modalsTraditional:
                ModalsTraditionalCommandsGalleryDataFactory()
            case .modalsSpecial:
                ModalsSpecialCommandsGalleryDataFactory()
            case .stack:
                StackCommandsGalleryDataFactory()
            case .urlHandling:
                URLHandlingCommandsGalleryDataFactory()
            }
        }()
        self.title = factory.makeTitle()
        self.items = factory.makeItems()
    }

    var body: some View {
        scrollView
            .navigationTitle(title)
            .toolbar {
                if navigationNode.canExecuteCommand(DismissJustFromPresentedNavigationCommand()) {
                    ToolbarItem(placement: .topBarTrailing) {
                        dismissButton
                    }
                }
            }
            .presentationDetents(inputData.addPresentationDetents ? [.medium, .large] : [])
    }

    private var dismissButton: some View {
        Button(action: { navigationNode.executeCommand(DismissNavigationCommand()) }) {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .tint(SharedColor.grayscaleSecondary)
                .font(.system(size: 24))
        }
    }

    private var scrollView: some View {
        ScrollView {
            itemsView
                .padding()
        }.background(SharedColor.backgroundGray)

    }
    private var itemsView: some View {
        VStack(spacing: 8) {
            ForEach(items, id: \.identifiableViewModel.id) { item in
                if #available(iOS 18.0, *), let wrappedNavigationStackNodeNamespace {
                    configuredItemViewWithPresentingNavigationSource(for: item)
                        .matchedTransitionSource(
                            id: item.identifiableViewModel.id,
                            in: wrappedNavigationStackNodeNamespace
                        )
                } else {
                    configuredItemViewWithPresentingNavigationSource(for: item)
                }
            }
        }
    }

    private func configuredItemViewWithPresentingNavigationSource(
        for item: CommandsGalleryItem
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
        for item: IdentifiableViewModel<String, CommandsGalleryItemView.ViewModel>
    ) -> some View {
        CommandsGalleryItemView(
            viewModel: item.viewModel,
            action: { handleAction(for: item.id) }
        )
    }

    // MARK: Actions

    private func handleAction(for itemID: String) {
        guard let makeCommand = items.first(where: { $0.identifiableViewModel.id == itemID })?.makeCommand else { return }
        navigationNode.executeCommand(makeCommand(navigationNode))
    }

}

#Preview {
    CommandsGalleryNavigationNode(inputData: CommandsGalleryInputData(id: .home)).view
}

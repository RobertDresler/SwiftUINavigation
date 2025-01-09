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
            case .modal:
                ModalCommandsGalleryDataFactory()
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
            ForEach(items.map(\.identifiableViewModel)) { item in
                CommandsGalleryItemView(
                    viewModel: item.viewModel,
                    action: { handleAction(for: item.id) }
                )
            }
        }
    }

    private var pushModuleAButton: some View {
        Button("Push Module A", action: { pushModuleA() })
    }

    private var pushModuleAWithoutAnimationButton: some View {
        Button("Push Module A Without Animation", action: { pushModuleAWithoutAnimation() })
    }

    private var presentModuleBAsFullScreenCoverButton: some View {
        Button("Present Module B as fullScreenCover", action: { presentModuleBAsFullScreenCover() })
    }

    private var presentModuleBAsSheetButton: some View {
        Button("Present Module B as sheet", action: { presentModuleBAsSheet() })
    }

    private var presentModuleBAsSheetWithDetentsButton: some View {
        Button("Present Module B as sheetWithDetents", action: { presentModuleBAsSheetWithDetents() })
    }

    private var setModuleBRootButton: some View {
        Button("Set Module B Root", action: { setModuleBRoot() })
    }

    private var showAlertButton: some View {
        Button("Show alert", action: { })// navigationNode.presentAlert() })
    }

    private var openURLButton: some View {
        Button("Open URL", action: { openURL() })
    }

    private var pushModuleBButton: some View {
        Group {
            if #available(iOS 18.0, *), let wrappedNavigationStackNodeNamespace {
                Button(action: { pushModuleB() }) {
                    Text("Push Module B")
                        .padding(64)
                        .background(Material.regular)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }.matchedTransitionSource(id: pushModuleBSourceID, in: wrappedNavigationStackNodeNamespace)
            } else {
                EmptyView()
            }
        }
    }

    // MARK: Actions

    private func handleAction(for itemID: String) {
        guard let makeCommand = items.first(where: { $0.identifiableViewModel.id == itemID })?.makeCommand else { return }
        navigationNode.executeCommand(makeCommand())
    }

    private func pushModuleA() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData()))
            )
        )
    }

    private func pushModuleAWithoutAnimation() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData(), animated: false))
            )
        )
    }

    private func pushModuleB() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(
                    destination: .moduleB(
                        ModuleBInputData(
                            text: "Pushed",
                            showRule: .push(.zoom(sourceID: pushModuleBSourceID))
                        )
                    )
                )
            )
        )
    }

    private var pushModuleBSourceID: String {
        "pushModuleBSourceID"
    }

    private func presentModuleBAsFullScreenCover() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(
                    destination: .moduleB(
                        ModuleBInputData(
                            text: "Presented as fullScreenCover",
                            showRule: .present(style: .fullScreenCover)
                        )
                    )
                )
            )
        )
    }

    private func presentModuleBAsSheet() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(
                    destination: .moduleB(
                        ModuleBInputData(
                            text: "Presented as sheet",
                            showRule: .present(style: .sheet)// TODO: -RD- implement(detents: []))
                        )
                    )
                )
            )
        )
    }

    private func presentModuleBAsSheetWithDetents() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(
                    destination: .moduleB(
                        ModuleBInputData(
                            text: "Presented as sheet with detents",
                            showRule: .present(style: .sheet)// TODO: -RD- implement(detents: [.medium, .large]))
                        )
                    )
                )
            )
        )
    }

    private func setModuleBRoot() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(
                    destination: .moduleB(
                        ModuleBInputData(
                            text: "Set root",
                            showRule: .setRoot
                        )
                    )
                )
            )
        )
    }

    private func showAlert() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(
                    destination: .alert(
                        AlertInputData(
                            title: "Test title",
                            message: "Test message"
                        )
                    )
                )
            )
        )
    }

    private func openURL() {
        guard let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") else { return }
        navigationNode.executeCommand(OpenURLNavigationCommand(url: url))
    }

}

#Preview {
    CommandsGalleryNavigationNode(inputData: CommandsGalleryInputData(id: .home)).view
}

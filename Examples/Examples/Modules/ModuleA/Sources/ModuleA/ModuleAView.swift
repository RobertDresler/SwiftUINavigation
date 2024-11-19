import SwiftUI
import ExamplesNavigation
import SwiftUINavigation

struct ModuleAView: View {

    @EnvironmentNavigationNode private var navigationNode: ModuleANavigationNode
    @Environment(\.stackNavigationNamespace) private var wrappedNavigationStackNodeNamespace
    var inputData: ModuleAInputData

    var body: some View {
        VStack(spacing: 64) {
            VStack {
                pushModuleAButton
                pushModuleAWithoutAnimationButton
                presentModuleBAsFullScreenCoverButton
                presentModuleBAsSheetButton
                presentModuleBAsSheetWithDetentsButton
                setModuleBRootButton
                //showAlertButton
                openURLButton
            }
            pushModuleBButton
            showAlertButton
        }.navigationTitle("Module A")
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
        Button("Show alert", action: { navigationNode.presentAlert(sourceID: "Tea") })
            .presentingNavigationSource(id: "Tea")
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

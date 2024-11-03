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
                presentModuleBButton
                setModuleBRootButton
                //showAlertButton
                openURLButton
            }
            pushModuleBButton
        }.navigationTitle("Module A")
    }

    private var pushModuleAButton: some View {
        Button("Push Module A", action: { pushModuleA() })
    }

    private var presentModuleBButton: some View {
        Button("Present Module B", action: { presentModuleB() })
    }

    private var setModuleBRootButton: some View {
        Button("Set Module B Root", action: { setModuleBRoot() })
    }

  //  private var showAlertButton: some View {
  //      Button("Show alert", action: { showAlert() })
  //  }

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
        navigationNode.handleDeepLink(ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData())))
    }

    private func pushModuleB() {
        navigationNode.handleDeepLink(
            ExamplesNavigationDeepLink(
                destination: .moduleB(
                    ModuleBInputData(
                        text: "Pushed",
                        showRule: .push(.zoom(sourceID: pushModuleBSourceID))
                    )
                )
            )
        )
    }

    private var pushModuleBSourceID: String {
        "pushModuleBSourceID"
    }

    private func presentModuleB() {
        navigationNode.handleDeepLink(
            ExamplesNavigationDeepLink(
                destination: .moduleB(
                    ModuleBInputData(
                        text: "Presented",
                        showRule: .present
                    )
                )
            )
        )
    }

    private func setModuleBRoot() {
        navigationNode.handleDeepLink(
            ExamplesNavigationDeepLink(
                destination: .moduleB(
                    ModuleBInputData(
                        text: "Set root",
                        showRule: .setRoot
                    )
                )
            )
        )
    }

    private func openURL() {
        guard let url = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ") else { return }
        navigationNode.executeCommand(.openURL(url))
    }

}

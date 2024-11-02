import SwiftUI
import ExamplesNavigation
import SwiftUINavigation

struct ModuleAView: View {

    @Environment(\.wrappedNavigationStackNodeNamespace) private var wrappedNavigationStackNodeNamespace
    var inputData: ModuleAInputData
    var executeNavigationCommand: (SwiftUINavigationNode<ExamplesNavigationDeepLink>.Command) -> Void

    var body: some View {
        VStack(spacing: 64) {
            VStack {
                pushModuleAButton
                presentModuleBButton
                setModuleBRootButton
                showAlertButton
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

    private var showAlertButton: some View {
        Button("Show alert", action: { showAlert() })
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
        executeNavigationCommand(
            .append(
                StackDeepLink(
                    destination: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData())),
                    transition: nil
                )
            )
        )
    }

    private func pushModuleB() {
        executeNavigationCommand(
            .append(
                StackDeepLink(
                    destination: ExamplesNavigationDeepLink(destination: .moduleB(ModuleBInputData(text: "Pushed"))),
                    transition: .zoom(sourceID: pushModuleBSourceID)
                )
            )
        )
    }

    private var pushModuleBSourceID: String {
        "pushModuleBSourceID"
    }

    private func presentModuleB() {
        executeNavigationCommand(
            .presentSheet(
                ExamplesNavigationDeepLink(destination: .moduleB(ModuleBInputData(text: "Test present")))
            )
        )
    }

    private func setModuleBRoot() {
        executeNavigationCommand(
            .setRoot(
                ExamplesNavigationDeepLink(destination: .moduleB(ModuleBInputData(text: "Test Set Root"))),
                clear: true
            )
        )
    }

    private func showAlert() {
        executeNavigationCommand(
            .alert(
                AlertConfig(
                    title: "Some title",
                    message: "Some message",
                    actions: [
                        AlertConfig.Action(title: "Cancel", role: .cancel),
                        AlertConfig.Action(title: "Dismiss", role: .destructive)
                    ]
                )
            )
        )
    }

}

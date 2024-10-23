import SwiftUI
import ExamplesNavigation
import SwiftUINavigation

struct ModuleAView: View {

    var inputData: ModuleAInputData
    var executeNavigationCommand: (CustomNavigationStackPathHolder<ExamplesNavigationDeepLink>.Command) -> Void

    var body: some View {
        VStack {
            pushModuleBButton
            presentModuleBButton
            setModuleBRootButton
            showAlertButton
        }.navigationTitle("Module A")
    }

    private var pushModuleBButton: some View {
        Button("Push Module B", action: { pushModuleB() })
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

    // MARK: Actions

    private func pushModuleB() {
        executeNavigationCommand(
            .append(
                ExamplesNavigationDeepLink(destination: .moduleB(ModuleBInputData(text: "Test push")))
            )
        )
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
                ExamplesNavigationDeepLink(destination: .moduleB(ModuleBInputData(text: "Test Set Root")))
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

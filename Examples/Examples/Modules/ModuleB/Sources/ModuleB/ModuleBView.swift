import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

struct ModuleBView: View {

    @EnvironmentNavigationNode private var navigationNode: SwiftUINavigationNode
    var inputData: ModuleBInputData

    var body: some View {
        VStack {
            text
            dismissButton
            pushModuleAButton
        }
            .navigationTitle("Module B")
    }

    private var text: some View {
        Text(inputData.text)
    }

    private var dismissButton: some View {
        Button("Dismiss", action: { dismiss() })
    }

    private var pushModuleAButton: some View {
        Button("Push Module A", action: { pushModuleA() })
    }

    // MARK: Actions

    private func dismiss() {
        navigationNode.executeCommand(.dismiss)
    }

    private func pushModuleA() {
        navigationNode.handleDeepLink(ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData())))
    }

}

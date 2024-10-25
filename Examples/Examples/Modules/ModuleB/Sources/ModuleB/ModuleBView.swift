import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

struct ModuleBView: View {

    var inputData: ModuleBInputData
    var executeNavigationCommand: (SwiftUINavigationNode<ExamplesNavigationDeepLink>.Command) -> Void

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
        executeNavigationCommand(.dismiss)
    }

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

}

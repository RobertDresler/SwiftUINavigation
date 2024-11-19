import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

struct ModuleBView: View {

    @EnvironmentNavigationNode private var navigationNode: ModuleBNavigationNode
    var inputData: ModuleBInputData

    var body: some View {
        VStack {
            text
            hideButton
            pushModuleAButton
        }
            .navigationTitle("Module B")
    }

    private var text: some View {
        Text(inputData.text)
    }

    private var hideButton: some View {
        Button("Hide", action: { hide() })
    }

    private var pushModuleAButton: some View {
        Button("Push Module A", action: { pushModuleA() })
    }

    // MARK: Actions

    private func hide() {
        navigationNode.hide()
    }

    private func pushModuleA() {
        navigationNode.executeCommand(
            DefaultHandleDeepLinkNavigationCommand(
                deepLink: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData()))
            )
        )
    }

}

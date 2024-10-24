import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

struct ModuleBView: View {

    var inputData: ModuleBInputData
    var executeNavigationCommand: (SwiftUINavigationGraphNode<ExamplesNavigationDeepLink>.Command) -> Void

    var body: some View {
        VStack {
            text
            dismissButton
        }
            .navigationTitle("Module B")
    }

    private var text: some View {
        Text(inputData.text)
    }

    private var dismissButton: some View {
        Button("Dismiss", action: { dismiss() })
    }

    // MARK: Actions

    private func dismiss() {
        executeNavigationCommand(.dismiss)
    }

}

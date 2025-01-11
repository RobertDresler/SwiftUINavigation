import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Shared

struct ArchitectureComposableView: View {

    @EnvironmentNavigationNode private var navigationNode: ArchitectureComposableNavigationNode
    @ObservedObject var viewModel: ArchitectureComposableViewModel

    var body: some View {
        VStack(spacing: 0) {
            nameEditor
            Spacer()
            saveButton
        }
            .padding()
            .background(SharedColor.backgroundGray)
    }

    private var nameEditor: some View {
        CustomTextEditor(
            text: Binding(
                get: { viewModel.state.name },
                set: { viewModel.handleAction(.setName($0)) }
            )
        )
    }

    private var saveButton: some View {
        PrimaryButton(title: "Save", action: { viewModel.handleAction(.save) })
    }

}

#Preview {
    ArchitectureComposableNavigationNode(inputData: ArchitectureComposableInputData(initialName: "Anna")).view
}

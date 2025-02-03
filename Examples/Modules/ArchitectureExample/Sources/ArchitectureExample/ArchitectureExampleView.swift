import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Shared

struct ArchitectureExampleView: View {

    @EnvironmentNavigationModel private var navigationModel: ArchitectureExampleNavigationModel
    @ObservedObject var viewModel: ArchitectureExampleViewModel

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
            text: $viewModel.name
        )
    }

    private var saveButton: some View {
        PrimaryButton(title: "Save", action: { viewModel.save() })
    }

}

#Preview {
    ArchitectureExampleNavigationModel(inputData: ArchitectureExampleInputData(initialName: "Anna")).body
}

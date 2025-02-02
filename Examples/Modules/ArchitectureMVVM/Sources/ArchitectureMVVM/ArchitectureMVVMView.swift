import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Shared

struct ArchitectureMVVMView: View {

    @EnvironmentNavigationModel private var navigationModel: ArchitectureMVVMNavigationModel
    @ObservedObject var viewModel: ArchitectureMVVMViewModel

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
                get: { viewModel.name },
                set: { viewModel.setName($0) }
            )
        )
    }

    private var saveButton: some View {
        PrimaryButton(title: "Save", action: { viewModel.save() })
    }

}

#Preview {
    ArchitectureMVVMNavigationModel(inputData: ArchitectureMVVMInputData(initialName: "Anna")).body
}

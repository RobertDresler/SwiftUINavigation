import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import Shared

struct ArchitectureViewOnlyView: View {

    @EnvironmentNavigationModel private var navigationModel: ArchitectureViewOnlyNavigationModel
    @State private var name: String

    var inputData: ArchitectureViewOnlyInputData

    init(inputData: ArchitectureViewOnlyInputData) {
        self.name = inputData.initialName
        self.inputData = inputData
    }

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
        CustomTextEditor(text: $name)
    }

    private var saveButton: some View {
        PrimaryButton(title: "Save", action: { save() })
    }

    // MARK: Actions

    private func save() {
        navigationModel.hide()
    }

}

#Preview {
    ArchitectureViewOnlyNavigationModel(inputData: ArchitectureViewOnlyInputData(initialName: "Anna")).body
}

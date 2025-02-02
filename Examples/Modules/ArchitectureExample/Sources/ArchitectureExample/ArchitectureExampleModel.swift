import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

@MainActor final class ArchitectureExampleModel: ObservableObject {

    @Published var name: String
    private unowned let navigationModel: ArchitectureExampleNavigationModel

    init(inputData: ArchitectureExampleInputData, navigationModel: ArchitectureExampleNavigationModel) {
        self.name = inputData.initialName
        self.navigationModel = navigationModel
    }

    func save() {
        navigationModel.hide()
    }

}


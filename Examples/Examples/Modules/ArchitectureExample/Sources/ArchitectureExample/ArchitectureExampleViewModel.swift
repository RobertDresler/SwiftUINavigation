import SwiftUINavigation
import SwiftUI
import Shared

@MainActor final class ArchitectureExampleViewModel: ObservableObject {

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


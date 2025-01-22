import ExamplesNavigation
import SwiftUI

final class ArchitectureMVVMViewModel: ObservableObject {

    @Published var name: String

    private let inputData: ArchitectureMVVMInputData
    private let eventHandler: (ArchitectureMVVMViewEvent) -> Void

    init(inputData: ArchitectureMVVMInputData, eventHandler: @escaping (ArchitectureMVVMViewEvent) -> Void) {
        self.inputData = inputData
        self.eventHandler = eventHandler
        self.name = inputData.initialName
    }

    func setName(_ name: String) {
        self.name = name
    }

    func save() {
        eventHandler(.hide)
    }

}

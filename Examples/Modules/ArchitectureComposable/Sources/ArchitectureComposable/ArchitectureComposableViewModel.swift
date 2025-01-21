import ExamplesNavigation
import SwiftUI

final class ArchitectureComposableViewModel: ObservableObject {

    struct State {
        var name: String
    }

    enum Action {
        case setName(String)
        case save
    }

    @Published var state: State

    private let inputData: ArchitectureComposableInputData
    private let eventHandler: (ArchitectureComposableViewEvent) -> Void

    init(inputData: ArchitectureComposableInputData, eventHandler: @escaping (ArchitectureComposableViewEvent) -> Void) {
        self.inputData = inputData
        self.eventHandler = eventHandler
        self.state = State(name: inputData.initialName)
    }

    func handleAction(_ action: Action) {
        switch action {
        case .setName(let name):
            state.name = name
        case .save:
            eventHandler(.hide)
        }
    }

}

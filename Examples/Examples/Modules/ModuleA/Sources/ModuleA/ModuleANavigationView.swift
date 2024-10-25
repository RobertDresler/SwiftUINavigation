import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

public struct ModuleANavigationView: View {

    @EnvironmentObject private var node: SwiftUINavigationNode<ExamplesNavigationDeepLink>
    private let inputData: ModuleAInputData

    public init(inputData: ModuleAInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ModuleAView(
            inputData: inputData,
            executeNavigationCommand: { node.executeCommand($0) }
        ).onAppear {
            let node = node
            Task {
                try? await Task.sleep(for: .seconds(5))
                let node = node
            }
        }
    }
}

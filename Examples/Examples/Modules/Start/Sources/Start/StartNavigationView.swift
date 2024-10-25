import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

public struct StartNavigationView: View {

    @EnvironmentObject private var node: SwiftUINavigationNode<ExamplesNavigationDeepLink>
    private let inputData: StartInputData

    public init(inputData: StartInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        StartView(
            inputData: inputData,
            executeNavigationCommand: { node.executeCommand($0) }
        ).onAppear {
            let node = node
        }
    }
}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

public struct ModuleANavigationView: View {

    @EnvironmentObject private var pathHolder: CustomNavigationStackPathHolder<ExamplesNavigationDeepLink>
    private let inputData: ModuleAInputData

    public init(inputData: ModuleAInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ModuleAView(
            inputData: inputData,
            executeNavigationCommand: { pathHolder.executeCommand($0) }
        )
    }
}

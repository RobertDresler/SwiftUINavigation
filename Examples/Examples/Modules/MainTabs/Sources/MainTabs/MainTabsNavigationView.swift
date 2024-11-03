import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

public struct MainTabsNavigationView: View {

    @EnvironmentObject private var node: NavigationNode
    private let inputData: MainTabsInputData

    public init(inputData: MainTabsInputData) {
        self.inputData = inputData
    }

    public var body: some View {
       /* TabView
        ModuleAView(
            inputData: inputData,
            executeNavigationCommand: { node.executeCommand($0) }
        ).onAppear {
            let node = node
            Task {
                try? await Task.sleep(for: .seconds(5))
                let node = node
            }
        }*/
        EmptyView()
    }
}

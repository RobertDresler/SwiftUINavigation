/*import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

public struct AppNavigationView<Resolver: SwiftUINavigationDeepLinkResolver>: View where Resolver.DeepLink == ExamplesNavigationDeepLink {

    @EnvironmentObject private var node: SwiftUINavigationGraphNode<ExamplesNavigationDeepLink>
    @EnvironmentObject private var userRepository: UserRepository

    private let inputData: AppInputData

    public init(inputData: AppInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        siwtchx
        SwiftUINavigationSwitchedNode<Resolver>(parentNode: node, defaultDeepLink: <#T##ExamplesNavigationDeepLink#>)
            .onAppear {
                Task {
                    try? await Task.sleep(for: .seconds(10))
                    let node = node
                }
            }
    }

    private func setSwitchedNode(isUserLogged: Bool) {
        let deepLink = isUserLogged
            ? ExamplesNavigationDeepLink(destination: .logged(ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData()))))
            : ExamplesNavigationDeepLink(destination: .notLogged(ExamplesNavigationDeepLink(destination: .start(StartInputData()))))
        node.executeCommand(.switchNode(deepLink))
    }

}*/

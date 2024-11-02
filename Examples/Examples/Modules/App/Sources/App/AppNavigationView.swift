import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

public struct AppNavigationView<Resolver: SwiftUINavigationDeepLinkResolver>: View where Resolver.DeepLink == ExamplesNavigationDeepLink {

    @EnvironmentObject private var node: SwiftUINavigationNode<ExamplesNavigationDeepLink>
    @EnvironmentObject private var userRepository: UserRepository
    @State private var deepLink = ExamplesNavigationDeepLink(destination: .start(StartInputData()))

    private let inputData: AppInputData

    public init(inputData: AppInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        SwiftUINavigationSwitchedNodeResolvedView<Resolver>()
            .onReceive(userRepository.$isUserLogged) { setDeepLink(isUserLogged: $0) }
            .onShake { node.printDebugGraph() }
    }

    private func setDeepLink(isUserLogged: Bool) {
        let switchedNode = isUserLogged ? loggedNode : notLoggedNode
        node.executeCommand(.switchNode(switchedNode))
    }

    private var notLoggedNode: SwiftUINavigationNode<ExamplesNavigationDeepLink> {
        SwiftUINavigationNode(
            type: .standalone,
            value: .deepLink(ExamplesNavigationDeepLink(destination: .start(StartInputData()))),
            parent: node
        )
    }

    private var loggedNode: SwiftUINavigationNode<ExamplesNavigationDeepLink> {
        SwiftUINavigationNode(
            type: .stackRoot,
            value: .stackRoot,
            parent: node,
            stackNodes: [StackDeepLink(destination: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData())))]
        )
    }

}

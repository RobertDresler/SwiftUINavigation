import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import UserRepository

public struct AppNavigationView<Resolver: SwiftUINavigationDeepLinkResolver>: View where Resolver.DeepLink == ExamplesNavigationDeepLink {

    @EnvironmentObject private var node: SwiftUINavigationGraphNode<ExamplesNavigationDeepLink>
    @EnvironmentObject private var userRepository: UserRepository
    @State private var deepLink = ExamplesNavigationDeepLink(destination: .notLogged(ExamplesNavigationDeepLink(destination: .start(StartInputData()))))

    private let inputData: AppInputData

    public init(inputData: AppInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        SwiftUINavigationSwitchedNodeResolvedView<Resolver>(deepLink: deepLink)
            .onReceive(userRepository.$isUserLogged) { setDeepLink(isUserLogged: $0) }
            .onAppear {
                Task {
                    try? await Task.sleep(for: .seconds(10))
                    let node = node
                }
            }
    }

    private func setDeepLink(isUserLogged: Bool) {
        deepLink = isUserLogged
            ? ExamplesNavigationDeepLink(destination: .logged(ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData()))))
            : ExamplesNavigationDeepLink(destination: .notLogged(ExamplesNavigationDeepLink(destination: .start(StartInputData()))))
    }

}

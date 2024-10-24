import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

public struct AppNavigationView<Resolver: SwiftUINavigationDeepLinkResolver>: View where Resolver.DeepLink == ExamplesNavigationDeepLink {

    @State private var isLogged = false

    private let inputData: AppInputData

    public init(inputData: AppInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        Group {
            if isLogged {
                loggedView
            } else {
                notLoggedView
            }
        }
    }

    private var loggedView: some View {
        SwiftUINavigationStack<ExamplesNavigationDeepLink, Resolver>(
            root: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData()))
        )
    }

    private var notLoggedView: some View {
        VStack {
            Text("User not logged")
            Button("Login", action: { isLogged = true })
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ExamplesNavigationResolving

public struct AppNavigationView: View {

    public init() {}

    public var body: some View {
        CustomNavigationStack(
            root: ExamplesNavigationDeepLink(destination: .moduleA(ModuleAInputData())),
            resolvedDestination: { ExamplesNavigationDeepLinkResolverView(deepLink: $0) }
        )
    }

}

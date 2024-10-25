import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ModuleA
import ModuleB
import App
import Start

public final class ExamplesNavigationDeepLinkResolver: SwiftUINavigationDeepLinkResolver {

    public init() {}

    public func resolve(_ deepLink: ExamplesNavigationDeepLink) -> some View {
        Group {
            switch deepLink.destination {
            case .root(let deepLink):
                SwiftUINavigationSwitchedNode<ExamplesNavigationDeepLinkResolver>(deepLink: deepLink)
            case .notLogged(let deepLink):
                SwiftUINavigationStandaloneNode<ExamplesNavigationDeepLinkResolver>(deepLink: deepLink)
            case .logged(let deepLink):
                SwiftUINavigationStackNode<ExamplesNavigationDeepLinkResolver>(deepLink: deepLink)
            case .app(let inputData):
                AppNavigationView<ExamplesNavigationDeepLinkResolver>(inputData: inputData)
            case .start(let inputData):
                StartNavigationView(inputData: inputData)
            case .moduleA(let inputData):
                ModuleANavigationView(inputData: inputData)
            case .moduleB(let inputData):
                ModuleBNavigationView(inputData: inputData)
            }
        }
    }

}

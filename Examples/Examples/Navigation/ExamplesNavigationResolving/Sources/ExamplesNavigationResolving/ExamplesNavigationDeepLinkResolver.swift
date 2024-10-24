import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ModuleA
import ModuleB
import App

public final class ExamplesNavigationDeepLinkResolver: SwiftUINavigationDeepLinkResolver {

    public func resolve(_ deepLink: ExamplesNavigationDeepLink) -> some View {
        Group {
            switch deepLink.destination {
            case .app(let inputData):
                AppNavigationView<ExamplesNavigationDeepLinkResolver>(inputData: inputData)
            case .moduleA(let inputData):
                ModuleANavigationView(inputData: inputData)
            case .moduleB(let inputData):
                ModuleBNavigationView(inputData: inputData)
            }
        }
    }

}

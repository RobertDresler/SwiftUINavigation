import SwiftUI
import ExamplesNavigation
import ModuleA
import ModuleB

public struct ExamplesNavigationDeepLinkResolverView: View {

    private let deepLink: ExamplesNavigationDeepLink

    public init(deepLink: ExamplesNavigationDeepLink) {
        self.deepLink = deepLink
    }

    public var body: some View {
        Group {
            switch deepLink.destination {
            case .moduleA(let inputData):
                ModuleANavigationView(inputData: inputData)
            case .moduleB(let inputData):
                ModuleBNavigationView(inputData: inputData)
            }
        }
    }

}

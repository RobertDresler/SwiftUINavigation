import SwiftUINavigation

public struct ExamplesNavigationDeepLink: NavigationDeepLink {

    public indirect enum Destination: Hashable {
        case notLogged(ExamplesNavigationDeepLink)
        case logged(ExamplesNavigationDeepLink)
      //  case app(AppInputData)
        case start(StartInputData)
        case moduleA(ModuleAInputData)
        case moduleB(ModuleBInputData)
    }

    public let destination: Destination

    public init(destination: Destination) {
        self.destination = destination
    }

}

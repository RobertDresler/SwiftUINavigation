import SwiftUINavigation

public struct ExamplesNavigationDeepLink: NavigationDeepLink {

    public enum Destination: Hashable {
        case moduleA(ModuleAInputData)
        case moduleB(ModuleBInputData)
    }

    public let destination: Destination

    public init(destination: Destination) {
        self.destination = destination
    }

}

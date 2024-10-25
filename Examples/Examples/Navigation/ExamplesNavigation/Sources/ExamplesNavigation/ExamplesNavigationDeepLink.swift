import SwiftUINavigation
import Foundation

public struct ExamplesNavigationDeepLink: NavigationDeepLink {

    public indirect enum Destination: Hashable {
        case root(ExamplesNavigationDeepLink)
        case notLogged(ExamplesNavigationDeepLink)
        case logged(ExamplesNavigationDeepLink)
        case app(AppInputData)
        case start(StartInputData)
        case moduleA(ModuleAInputData)
        case moduleB(ModuleBInputData)
    }

    public var debugName: String? {
        switch destination {
        case .root:
            "root"
        case .notLogged:
            "notLogged"
        case .logged:
            "logged"
        case .app:
            "app"
        case .start:
            "start"
        case .moduleA:
            "moduleA"
        case .moduleB:
            "moduleB"
        }
    }

    public let destination: Destination
    public let instanceID: String

    public init(destination: Destination) {
        self.destination = destination
        instanceID = UUID().uuidString
    }

}

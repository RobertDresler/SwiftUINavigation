import SwiftUINavigation
import Foundation

public struct ExamplesNavigationDeepLink: NavigationDeepLink {

    public indirect enum Destination: Hashable {
        case moduleA(ModuleAInputData)
        case moduleB(ModuleBInputData)
        case mainTabs(MainTabsInputData)
    }

    public let destination: Destination
    public let instanceID: String

    public init(destination: Destination) {
        self.destination = destination
        instanceID = UUID().uuidString
    }

}

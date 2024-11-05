import SwiftUINavigation
import Foundation

public struct ExamplesNavigationDeepLink: NavigationDeepLink {

    public indirect enum Destination: Hashable {
        case moduleA(ModuleAInputData)
        case moduleB(ModuleBInputData)
        case mainTabs(MainTabsInputData)
        case alert(AlertInputData)
    }

    public let destination: Destination

    public init(destination: Destination) {
        self.destination = destination
    }

}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ModuleA
import ModuleB
import App
import Start
import MainTabs

public final class ExamplesNavigationDeepLinkHandler: NavigationDeepLinkHandler {

    public typealias DeepLink = ExamplesNavigationDeepLink

    public init() {}

    public func handleDeepLink(_ deepLink: any NavigationDeepLink, on node: NavigationNode) {
        guard let deepLink = deepLink as? ExamplesNavigationDeepLink else { return }
        switch deepLink.destination {
        case .moduleA(let inputData):
            node.append(
                SwiftUINavigationNodeWithStackTransition(
                    destination: ModuleANavigationNode(inputData: inputData),
                    transition: nil
                )
            )
        case .moduleB(let inputData):
            let moduleNode = ModuleBNavigationNode(inputData: inputData)
            switch inputData.showRule {
            case .present:
                node.presentSheet(moduleNode)
            case .push(let transition):
                node.append(SwiftUINavigationNodeWithStackTransition(destination: moduleNode, transition: transition))
            case .setRoot:
                node.setRoot(moduleNode, clear: true)
            }
        case .mainTabs(let inputData):
            break // TODO: -RD- implement//MainTabsNavigationView(inputData: inputData)
        }
    }

}

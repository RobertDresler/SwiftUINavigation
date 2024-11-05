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
            node.executeCommand(
                .append(
                    NavigationNodeWithStackTransition(
                        destination: ModuleANavigationNode(inputData: inputData),
                        transition: nil
                    )
                )
            )
        case .moduleB(let inputData):
            let moduleNode = ModuleBNavigationNode(inputData: inputData)
            switch inputData.showRule {
            case .present(let style):
                switch style {
                case .fullScreenCover:
                    node.executeCommand(
                        .present(
                            PresentedNavigationNodeFullScreenCover.stacked(node: moduleNode)
                        )
                    )
                case .sheet:
                    break // TODO: -RD- implement
                }
            case .push(let transition):
                node.executeCommand(
                    .append(NavigationNodeWithStackTransition(destination: moduleNode, transition: transition))
                )
            case .setRoot:
                node.executeCommand(.setRoot(moduleNode, clear: true))
            }
        case .mainTabs(let inputData):
            break // TODO: -RD- implement//MainTabsNavigationView(inputData: inputData)
        case .alert(let inputData):
            node.executeCommand(.present(AlertPresentedNavigationNode(inputData: inputData)))
        }
    }

}

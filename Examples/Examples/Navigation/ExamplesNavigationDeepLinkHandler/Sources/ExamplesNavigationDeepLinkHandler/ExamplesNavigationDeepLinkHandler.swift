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
        case let .moduleA(inputData, animated):
            node.executeCommand(
                StackAppendNavigationCommand(
                    appendedNode: NavigationNodeWithStackTransition(
                        destination: ModuleANavigationNode(inputData: inputData),
                        transition: nil
                    ),
                    animated: animated
                )
            )
        case .moduleB(let inputData):
            let moduleNode = ModuleBNavigationNode(inputData: inputData)
            switch inputData.showRule {
            case .present(let style):
                switch style {
                case .fullScreenCover:
                    node.executeCommand(
                        PresentNavigationCommand(
                            presentedNode: PresentedNavigationNodeFullScreenCover.stacked(node: moduleNode)
                        )
                    )
                case .sheet:
                    break // TODO: -RD- implement
                }
            case .push(let transition):
                node.executeCommand(
                    StackAppendNavigationCommand(
                        appendedNode: NavigationNodeWithStackTransition(destination: moduleNode, transition: transition)
                    )
                )
            case .setRoot:
                node.executeCommand(
                    StackSetRootNavigationCommand(
                        rootNode: moduleNode,
                        clear: true
                    )
                )
            }
        case .alert(let inputData):
            node.executeCommand(
                PresentNavigationCommand(
                    presentedNode: AlertPresentedNavigationNode(inputData: inputData)
                )
            )
        }
    }

}

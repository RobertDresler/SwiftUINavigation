import SwiftUI

public enum NavigationNodeCommand {
    case append(NavigationNodeWithStackTransition)
    case removeLast(count: Int = 1)
    case removeAll
    case alert(AlertConfig)
    case presentSheet(NavigationNode)
    case dismiss
    case setRoot(NavigationNode, clear: Bool)
    case switchNode(NavigationNode)
    case openURL(URL)
}

import SwiftUINavigation

public struct RequestReviewNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        node.sendEnvironmentTrigger(RequestReviewNavigationEnvironmentTrigger())
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        true
    }

    public init() {}

}

import SwiftUINavigation

public struct RequestReviewNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.sendEnvironmentTrigger(RequestReviewNavigationEnvironmentTrigger())
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        true
    }

    public init() {}

}

import SwiftUINavigation

public struct RequestReviewNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        model.sendEnvironmentTrigger(RequestReviewNavigationEnvironmentTrigger())
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        true
    }

    public init() {}

}

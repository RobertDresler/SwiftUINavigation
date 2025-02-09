import SwiftUINavigation

public struct RequestReviewNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        model.sendEnvironmentTrigger(RequestReviewNavigationEnvironmentTrigger())
    }

    public init() {}

}

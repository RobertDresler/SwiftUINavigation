import Foundation

public struct OpenURLNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        model.sendEnvironmentTrigger(OpenURLNavigationEnvironmentTrigger(url: url))
    }

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

}

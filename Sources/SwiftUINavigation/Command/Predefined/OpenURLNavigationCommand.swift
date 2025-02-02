import Foundation

public struct OpenURLNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        model.sendEnvironmentTrigger(OpenURLNavigationEnvironmentTrigger(url: url))
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        true
    }

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

}

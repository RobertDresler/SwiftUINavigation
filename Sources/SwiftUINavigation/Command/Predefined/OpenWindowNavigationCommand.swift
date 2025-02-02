import Foundation

public struct OpenWindowNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        model.sendEnvironmentTrigger(OpenWindowNavigationEnvironmentTrigger(id: id))
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        true
    }

    private let id: String

    public init(id: String) {
        self.id = id
    }

}

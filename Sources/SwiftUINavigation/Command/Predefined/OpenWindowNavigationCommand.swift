import Foundation

public struct OpenWindowNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        model.sendEnvironmentTrigger(OpenWindowNavigationEnvironmentTrigger(id: id))
    }

    private let id: String

    public init(id: String) {
        self.id = id
    }

}

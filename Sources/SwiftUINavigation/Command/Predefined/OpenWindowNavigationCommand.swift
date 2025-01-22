import Foundation

public struct OpenWindowNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        node.sendEnvironmentTrigger(OpenWindowNavigationEnvironmentTrigger(id: id))
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        true
    }

    private let id: String

    public init(id: String) {
        self.id = id
    }

}

import Foundation

/// When you want to dismiss Window on iOS 16, call this command from the window you want to dismiss, from iOS 17, you can call this command from any Window
public struct DismissWindowNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        if #available(iOS 17, *) {
            node.sendEnvironmentTrigger(DismissWindowNavigationEnvironmentTrigger(id: id))
        } else {
            node.sendEnvironmentTrigger(DismissNavigationEnvironmentTrigger())
        }
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        true
    }

    private let id: String

    public init(id: String) {
        self.id = id
    }

}

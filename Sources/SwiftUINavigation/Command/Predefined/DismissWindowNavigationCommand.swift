import Foundation

/// When you want to dismiss Window on iOS 16/macOS 13, call this command from the window you want to dismiss, from iOS 17/macOS 14, you can call this command from any Window
public struct DismissWindowNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        if #available(iOS 17.0, macOS 14.0, *) {
            model.sendEnvironmentTrigger(DismissWindowNavigationEnvironmentTrigger(id: id))
        } else {
            model.sendEnvironmentTrigger(DismissNavigationEnvironmentTrigger())
        }
    }

    private let id: String

    public init(id: String) {
        self.id = id
    }

}

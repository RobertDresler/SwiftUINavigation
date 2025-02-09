import SwiftUI

@MainActor
public protocol NavigationCommand {
    func execute(on model: any NavigationModel)
    func canExecute(on model: any NavigationModel) -> Bool
}

// MARK: Default Implementations

public extension NavigationCommand {
    func canExecute(on model: any NavigationModel) -> Bool {
        true
    }
}

// MARK: Helper Methods

public extension NavigationCommand {
    func perform(animated: Bool, action: () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            action()
        }
    }
}

import SwiftUI

@MainActor
public protocol NavigationCommand {
    func execute(on node: any NavigationNode)
    func canExecute(on node: any NavigationNode) -> Bool
}

public extension NavigationCommand {
    func perform(animated: Bool, action: () -> Void) {
        var transaction = Transaction()
        transaction.disablesAnimations = !animated
        withTransaction(transaction) {
            action()
        }
    }
}

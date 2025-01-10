import SwiftUI

@MainActor
public protocol NavigationCommand {
    func execute(on node: NavigationNode)
    func canExecute(on node: NavigationNode) -> Bool
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

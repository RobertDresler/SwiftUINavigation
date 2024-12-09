import SwiftUI

public protocol NavigationCommand {
    func execute(on node: NavigationNode)
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

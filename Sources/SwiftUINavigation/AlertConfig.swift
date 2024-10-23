import SwiftUI

public struct AlertConfig {

    public struct Action {

        let title: String
        let handler: () -> Void
        let role: ButtonRole?

        public init(title: String, handler: @escaping () -> Void = {}, role: ButtonRole? = nil) {
            self.title = title
            self.handler = handler
            self.role = role
        }

    }

    let title: String
    let message: String
    let actions: [Action]

    public init(title: String, message: String, actions: [Action]) {
        self.title = title
        self.message = message
        self.actions = actions
    }

}

import Foundation

public struct AlertInputData: Hashable {

    public struct Action: Hashable {

        public enum Role {
            case cancel
            case destructive
        }

        let id: String
        let title: String
        let role: Role?
        let handler: (() -> Void)?

        public init(id: String = UUID().uuidString, title: String, role: Role? = nil, handler: (() -> Void)? = nil) {
            self.id = id
            self.title = title
            self.role = role
            self.handler = handler
        }

        public static func == (lhs: Action, rhs: Action) -> Bool {
            lhs.id == rhs.id
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

    }

    let title: String?
    let message: String?
    let actions: [Action]

    public init(title: String? = nil, message: String? = nil, actions: [Action] = []) {
        self.title = title
        self.message = message
        self.actions = actions
    }

}

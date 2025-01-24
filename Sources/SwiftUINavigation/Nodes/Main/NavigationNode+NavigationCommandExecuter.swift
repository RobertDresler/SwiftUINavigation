// MARK: NavigationCommandExecuter

@MainActor
public extension NavigationNode {
    func execute(_ command: NavigationCommand) {
        command.execute(on: self)
    }

    func canExecute(_ command: NavigationCommand) -> Bool {
        command.canExecute(on: self)
    }
}

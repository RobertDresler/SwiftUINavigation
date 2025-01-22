// MARK: NavigationCommandExecuter

@MainActor
public extension NavigationNode {
    func executeCommand(_ command: NavigationCommand) {
        command.execute(on: self)
    }

    func canExecuteCommand(_ command: NavigationCommand) -> Bool {
        command.canExecute(on: self)
    }
}

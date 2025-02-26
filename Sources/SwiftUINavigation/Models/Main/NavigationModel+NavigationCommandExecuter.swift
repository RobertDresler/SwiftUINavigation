// MARK: NavigationCommandExecuter

@MainActor
public extension NavigationModel {
    func execute(_ command: NavigationCommand) {
        command.execute(on: self)
    }

    func canExecute(_ command: NavigationCommand) -> Bool {
        command.canExecute(on: self)
    }
}

@MainActor
public protocol NavigationCommandExecuter {
    func execute(_ command: NavigationCommand)
    func canExecute(_ command: NavigationCommand) -> Bool
}

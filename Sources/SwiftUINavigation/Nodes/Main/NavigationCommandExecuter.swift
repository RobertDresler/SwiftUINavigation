@MainActor
public protocol NavigationCommandExecuter {
    func executeCommand(_ command: NavigationCommand)
    func canExecuteCommand(_ command: NavigationCommand) -> Bool
}

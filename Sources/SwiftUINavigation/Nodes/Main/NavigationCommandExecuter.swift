public protocol NavigationCommandExecuter {
    @MainActor func execute(_ command: NavigationCommand)
    @MainActor func canExecute(_ command: NavigationCommand) -> Bool
}

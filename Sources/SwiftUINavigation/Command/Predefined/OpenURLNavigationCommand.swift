import Foundation

public struct OpenURLNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.sendEnvironmentTrigger(OpenURLNavigationEnvironmentTrigger(url: url))
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        true
    }

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

}

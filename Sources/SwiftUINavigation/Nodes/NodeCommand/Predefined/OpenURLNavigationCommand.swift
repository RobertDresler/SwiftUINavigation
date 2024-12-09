import Foundation

public struct OpenURLNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        node.urlToOpen.send(url)
    }

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

}

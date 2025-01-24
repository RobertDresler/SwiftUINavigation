import SwiftUINavigation

public struct StackReverseNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        stackMapCommand(for: node).execute(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        stackMapCommand(for: node).canExecute(on: node)
    }

    private let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }

    private func stackMapCommand(for node: any NavigationNode) -> NavigationCommand {
        .stackMap(
            { nodes in
                nodes.reversed()
            },
            animated: animated
        )
    }

}

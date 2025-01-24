import SwiftUINavigation
import Foundation

public struct ShowAndHideAfterDelayNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        executablePresentCommand(on: node).execute(on: node)
        let hideDelay = hideDelay
        let animated = animated
        let hidePresentedNode = { @MainActor [weak presentedNode = presentedNode.node] in
            presentedNode?.execute(.dismiss(animated: animated))
        }
        Task {
            try? await Task.sleep(nanoseconds: UInt64(hideDelay * 1_000_000_000))
            hidePresentedNode()
        }
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        executablePresentCommand(on: node).canExecute(on: node)
    }

    private let presentedNode: any PresentedNavigationNode
    private let hideDelay: TimeInterval
    private let animated: Bool

    public init(presentedNode: any PresentedNavigationNode, hideDelay: TimeInterval, animated: Bool = true) {
        self.presentedNode = presentedNode
        self.hideDelay = hideDelay
        self.animated = animated
    }

    private func executablePresentCommand(on node: any NavigationNode) -> NavigationCommand {
        .present(presentedNode, animated: animated)
    }

}

import SwiftUINavigation
import Foundation

public struct ShowAndHideAfterDelayNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        executablePresentCommand(on: node).execute(on: node)
        let hideDelay = hideDelay
        let animated = animated
        let hidePresentedNode = { @MainActor [weak presentedNode = presentedNode.node] in
            presentedNode?.executeCommand(DismissNavigationCommand(animated: animated))
        }
        Task {
            try? await Task.sleep(nanoseconds: UInt64(hideDelay * 1_000_000_000))
            hidePresentedNode()
        }
    }

    public func canExecute(on node: NavigationNode) -> Bool {
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

    private func executablePresentCommand(on node: NavigationNode) -> NavigationCommand {
        PresentNavigationCommand(presentedNode: presentedNode, animated: animated)
    }

}

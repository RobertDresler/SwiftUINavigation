import SwiftUI
import Combine

public protocol NavigationNode: ObservableObject, NavigationCommandExecuter {
    associatedtype State: NavigationNodeState
    associatedtype Body: View
    @MainActor var body: Body { get }
    var isWrapperNode: Bool { get }
    var state: State { get }
    @MainActor func startIfNeeded(
        parent: (any NavigationNode)?,
        defaultDeepLinkHandler: NavigationDeepLinkHandler?
    ) async
    @MainActor func finishIfNeeded()
}

// MARK: Default Implementations

public extension NavigationNode {
    var isWrapperNode: Bool {
        true
    }

    @MainActor func startIfNeeded(
        parent: (any NavigationNode)?,
        defaultDeepLinkHandler: NavigationDeepLinkHandler?
    ) async {
        guard !state.didStart else { return }
        state.didStart = true
        Task {
            await start(parent: parent, defaultDeepLinkHandler: defaultDeepLinkHandler)
            printDebugText("Started")
        }
    }

    @MainActor func finishIfNeeded() {
        guard !state.didFinish else { return }
        state.didFinish = true
        finish()
    }
}

private extension NavigationNode {
    @MainActor func start(parent: (any NavigationNode)?, defaultDeepLinkHandler: NavigationDeepLinkHandler?) async {
        state.bind(with: self)
        state
            .objectWillChange
            .sink { [weak self] in
                guard let publisher = self?.objectWillChange as? ObservableObjectPublisher else { return }
                publisher.send()
            }
            .store(in: &state.cancellables)
        state._defaultDeepLinkHandler = defaultDeepLinkHandler
        await Task { @MainActor in /// This is needed since Publishing changes from within view updates is not allowed
            state.parent = parent
        }.value
    }

    @MainActor func finish() {
        sendMessage(RemovalNavigationMessage())
    }
}

import SwiftUI
import Combine

public protocol NavigationNode: ObservableObject, NavigationCommandExecuter {
    associatedtype State: NavigationNodeState
    associatedtype Body: View
    @MainActor var body: Body { get }
    @MainActor var isWrapperNode: Bool { get }
    var state: State { get }
    @MainActor func startIfNeeded()
}

// MARK: Default Implementations

@MainActor
public extension NavigationNode {
    var isWrapperNode: Bool {
        true
    }

    func startIfNeeded() {
        guard !state.didStart else { return }
        state.didStart = true
        state.bind(with: self)
        state
            .objectWillChange
            .sink { [weak self] in
                guard let publisher = self?.objectWillChange as? ObservableObjectPublisher else { return }
                publisher.send()
            }
            .store(in: &state.cancellables)
    }
}

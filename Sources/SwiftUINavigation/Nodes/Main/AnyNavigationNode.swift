import SwiftUI
import Combine

public final class AnyNavigationNode: NavigationNode {

    public var state: NavigationNodeState {
        base.state
    }

    public var body: some View {
        AnyView(base.body)
    }

    public var isWrapperNode: Bool {
        base.isWrapperNode
    }

    let base: any NavigationNode

    private var cancellables = Set<AnyCancellable>()

    public init<T: NavigationNode>(_ base: T) {
        self.base = base
        bind()
    }

    private func bind() {
        guard let publisher = base.objectWillChange as? ObjectWillChangePublisher else { return }
        publisher
            .sink { [weak self] in self?.objectWillChange.send() }
            .store(in: &cancellables)
    }

}

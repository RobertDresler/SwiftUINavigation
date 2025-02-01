import SwiftUI
import Combine

public final class AnyNavigationNode: NavigationNode {

    public let id: String
    public let commonState: CommonNavigationNodeState

    public var presentedNode: (any PresentedNavigationNode)? {
        get { base.presentedNode }
        set { base.presentedNode = newValue }
    }

    public var children: [any NavigationNode] {
        base.children
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
        self.id = base.id
        self.commonState = base.commonState
        self.base = base
        bind()
    }

    /// Binding like this is needed since withTransaction wouldn't work with that
    private func bind() {
        guard let publisher = base.objectWillChange as? ObjectWillChangePublisher else { return }
        publisher
            .sink { [weak self] in self?.objectWillChange.send() }
            .store(in: &cancellables)
    }

}

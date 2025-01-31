import SwiftUI
import Combine

public final class AnyNavigationNode: NavigationNode {

    public var state: NavigationNodeState {
        base.state
    }

    public var body: some View {
        if let objectWillChangePublisher = base.objectWillChange as? ObjectWillChangePublisher {
            AnyView(base.body)
                .onReceive(objectWillChangePublisher) { [weak self] _ in self?.objectWillChange.send() }
        }
    }

    public var isWrapperNode: Bool {
        base.isWrapperNode
    }

    let base: any NavigationNode

    public init<T: NavigationNode>(_ base: T) {
        self.base = base
    }

}

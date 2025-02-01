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
        self.id = base.id
        self.commonState = base.commonState
        self.base = base
    }

}

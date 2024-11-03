import SwiftUI

public final class StackRootNavigationNode: NavigationNode {

    @MainActor
    public override var view: AnyView {
        AnyView(StackRootNavigationNodeView())
    }

    public init(stackNodes: [SwiftUINavigationNodeWithStackTransition]) {
        super.init(stackNodes: stackNodes)
    }

}

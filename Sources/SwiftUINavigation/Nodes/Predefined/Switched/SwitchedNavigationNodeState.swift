import SwiftUI
import Combine

public class SwitchedNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public var switchedNode: (any NavigationNode)?

    // MARK: Getters

    public override var children: [any NavigationNode] {
        super.children + [switchedNode].compactMap { $0 }
    }

}

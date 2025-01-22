import SwiftUI
import Combine

public class SwitchedNavigationNodeState: NavigationNodeState {

    // MARK: Published

    @Published public internal(set) var switchedNode: (any NavigationNode)?

    // MARK: Getters

    public override var childrenPublishers: [any Publisher<[NavigationNode], Never>] {
        super.childrenPublishers
        + [$switchedNode.map { [$0].compactMap { $0 } }]
    }

}

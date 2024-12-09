import SwiftUI
import Combine

public final class TabsRootNavigationNode: NavigationNode {

    @Published public internal(set) var selectedTabNode: TabNode
    @Published public internal(set) var tabsNodes: [TabNode]
    public override var isWrapperNode: Bool { true }

    public override var childrenPublisher: AnyPublisher<[NavigationNode], Never> {
        super.childrenPublisher
            .merge(with: $tabsNodes.map { $0.map { $0.navigationNode }})
            .eraseToAnyPublisher()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(TabsRootNavigationNodeView())
    }

    public init(selectedTabNode: TabNode, tabsNodes: [TabNode]) {
        self.selectedTabNode = selectedTabNode
        self.tabsNodes = tabsNodes
    }

}

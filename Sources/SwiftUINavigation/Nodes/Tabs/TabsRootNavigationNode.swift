import SwiftUI
import Combine

// TODO: -RD- separate
// TODO: -RD- implement new iOS 18 Tab API
public protocol TabNode {
    var navigationNode: NavigationNode { get }
    @MainActor
    var resolvedView: AnyView { get }
}

public struct DefaultTabNode: TabNode {

    private let image: Image
    private let title: String
    public let navigationNode: NavigationNode

    public init(image: Image, title: String, navigationNode: NavigationNode) {
        self.image = image
        self.title = title
        self.navigationNode = navigationNode
    }

    @MainActor
    public var resolvedView: AnyView {
        AnyView(
            content
                .tabItem { label }
        )
    }

    @MainActor
    private var content: some View {
        NavigationNodeResolvedView(node: navigationNode)
    }

    private var label: some View {
        Label(
            title: { Text(title) },
            icon: { image }
        )
    }

}


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

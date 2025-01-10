import SwiftUI

// TODO: Implement new iOS 18 Tab API
public struct DefaultTabNode: TabNode {

    public let id: AnyHashable
    private let image: Image
    private let title: String
    public let navigationNode: NavigationNode

    public init(id: AnyHashable, image: Image, title: String, navigationNode: NavigationNode) {
        self.id = id
        self.image = image
        self.title = title
        self.navigationNode = navigationNode
    }

    public var resolvedView: AnyView {
        AnyView(
            content
                .tabItem { label }
        )
    }

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

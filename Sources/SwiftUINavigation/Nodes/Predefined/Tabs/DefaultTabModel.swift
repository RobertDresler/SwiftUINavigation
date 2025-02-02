import SwiftUI

// TODO: Implement new iOS 18 Tab API
public struct DefaultTabModel: TabModel {

    public let id: AnyHashable
    private let image: Image
    private let title: String
    public let navigationModel: any NavigationModel

    public init(id: AnyHashable, image: Image, title: String, navigationModel: any NavigationModel) {
        self.id = id
        self.image = image
        self.title = title
        self.navigationModel = navigationModel
    }

    public var resolvedView: AnyView {
        AnyView(
            content
                .tabItem { label }
        )
    }

    private var content: some View {
        NavigationModelResolvedView(model: navigationModel)
    }

    private var label: some View {
        Label(
            title: { Text(title) },
            icon: { image }
        )
    }

}

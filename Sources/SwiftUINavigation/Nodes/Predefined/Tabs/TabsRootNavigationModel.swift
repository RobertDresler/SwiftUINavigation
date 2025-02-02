import SwiftUI

public protocol TabsRootNavigationModel: NavigationModel {
    associatedtype ModifiedView: View
    var selectedTabModelID: AnyHashable { get set }
    var tabsModels: [TabModel] { get set }
    @ViewBuilder func body(for content: TabsRootNavigationModelView<Self>) -> ModifiedView
}

public extension TabsRootNavigationModel {
    var children: [any NavigationModel] {
        baseNavigationModelChildren + tabsModels.map(\.navigationModel)
    }

    var body: ModifiedView {
        body(for: TabsRootNavigationModelView())
    }
}

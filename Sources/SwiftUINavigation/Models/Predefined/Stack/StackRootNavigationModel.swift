import SwiftUI
import Combine

public protocol StackRootNavigationModel: NavigationModel {
    associatedtype ModifiedView: View
    var path: [StackNavigationModel] { get set }
    var tabBarToolbarBehavior: StackTabBarToolbarBehavior { get set }
    @ViewBuilder func body(for content: StackRootNavigationModelView<Self>) -> ModifiedView
}

public extension StackRootNavigationModel {
    var children: [any NavigationModel] {
        baseNavigationModelChildren + path.map(\.model)
    }

    var body: ModifiedView {
        body(for: StackRootNavigationModelView())
    }

    func setNewPath(_ newPath: [StackNavigationDestination]) {
        path = path.prefix(1)
        + newPath.compactMap { element in path.first(where: { $0.model.id == element.modelID }) }
    }
}

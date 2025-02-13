import SwiftUI
import Combine

public protocol StackRootNavigationModel: NavigationModel {
    associatedtype ModifiedView: View
    var stackModels: [StackNavigationModel] { get set }
    var tabBarToolbarBehavior: StackTabBarToolbarBehavior { get set }
    @ViewBuilder func body(for content: StackRootNavigationModelView<Self>) -> ModifiedView
}

public extension StackRootNavigationModel {
    var children: [any NavigationModel] {
        baseNavigationModelChildren + stackModels.map(\.destination)
    }

    var body: ModifiedView {
        body(for: StackRootNavigationModelView())
    }

    func setNewPath(_ newPath: [StackNavigationDestination]) {
        stackModels = stackModels.prefix(1)
        + newPath.compactMap { element in stackModels.first(where: { $0.destination.id == element.modelID }) }
    }
}

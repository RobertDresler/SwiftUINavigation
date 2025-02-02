import SwiftUI

public protocol SwitchedNavigationModel: NavigationModel {
    associatedtype ModifiedView: View
    var switchedModel: (any NavigationModel)? { get set }
    @ViewBuilder func body(for content: SwitchedNavigationModelView<Self>) -> ModifiedView
}

public extension SwitchedNavigationModel {
    var children: [any NavigationModel] {
        baseNavigationModelChildren + [switchedModel].compactMap { $0 }
    }

    var body: ModifiedView {
        body(for: SwitchedNavigationModelView())
    }
}

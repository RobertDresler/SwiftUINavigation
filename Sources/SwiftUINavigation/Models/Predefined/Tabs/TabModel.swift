import SwiftUI

@MainActor
public protocol TabModel {
    var id: AnyHashable { get }
    var navigationModel: any NavigationModel { get }
    var resolvedView: AnyView { get }
}

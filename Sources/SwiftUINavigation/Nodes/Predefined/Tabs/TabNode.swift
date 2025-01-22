import SwiftUI

@MainActor
public protocol TabNode {
    var id: AnyHashable { get }
    var navigationNode: any NavigationNode { get }
    var resolvedView: AnyView { get }
}

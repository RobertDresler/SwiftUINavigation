import SwiftUI

@MainActor
public protocol TabNode {
    var navigationNode: NavigationNode { get }
    var resolvedView: AnyView { get }
}

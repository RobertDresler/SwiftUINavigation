import SwiftUI

public protocol TabNode {
    var navigationNode: NavigationNode { get }
    @MainActor
    var resolvedView: AnyView { get }
}

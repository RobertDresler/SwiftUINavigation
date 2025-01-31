import SwiftUI

public protocol ModifiableSwitchedNavigationNode {
    associatedtype ModifiedView: View
    @MainActor @ViewBuilder func body(for content: SwitchedNavigationNodeView) -> ModifiedView
}

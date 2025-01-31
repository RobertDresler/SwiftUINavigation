import SwiftUI

public protocol ModifiableStackRootNavigationNode {
    associatedtype ModifiedView: View
    @MainActor @ViewBuilder func body(for content: StackRootNavigationNodeView) -> ModifiedView
}

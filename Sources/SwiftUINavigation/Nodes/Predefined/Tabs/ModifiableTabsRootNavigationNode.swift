import SwiftUI

public protocol ModifiableTabsRootNavigationNode {
    associatedtype ModifiedView: View
    @MainActor @ViewBuilder func body(for content: TabsRootNavigationNodeView) -> ModifiedView
}

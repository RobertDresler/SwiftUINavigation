import SwiftUI

#if os(iOS)
@available(iOS 18.0, *)
public struct ZoomStackNavigationTransition: StackNavigationTransition {

    public func toNavigationTransition(in namespace: Namespace.ID) -> NavigationTransition {
        .zoom(sourceID: sourceID, in: namespace)
    }

    let sourceID: String

}

@available(iOS 18.0, *)
public extension StackNavigationTransition where Self == ZoomStackNavigationTransition {
    static func zoom(sourceID: String) -> StackNavigationTransition {
        ZoomStackNavigationTransition(sourceID: sourceID)
    }
}
#endif

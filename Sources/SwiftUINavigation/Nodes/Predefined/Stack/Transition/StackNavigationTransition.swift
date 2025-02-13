import SwiftUI

public protocol StackNavigationTransition {
    @available(iOS 18.0, macOS 15.0, *)
    func toNavigationTransition(in namespace: Namespace.ID) -> NavigationTransition
}

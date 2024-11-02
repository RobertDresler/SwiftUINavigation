import SwiftUI

private struct WrappedNavigationStackNodeNamespace: EnvironmentKey {
    static let defaultValue: Namespace.ID? = nil
}

public extension EnvironmentValues {
    var wrappedNavigationStackNodeNamespace: Namespace.ID? {
        get { self[WrappedNavigationStackNodeNamespace.self] }
        set { self[WrappedNavigationStackNodeNamespace.self] = newValue }
    }
}

extension View {
    func wrappedNavigationStackNodeNamespace(_ namespace: Namespace.ID?) -> some View {
        Group {
            if let namespace {
                environment(\.wrappedNavigationStackNodeNamespace, namespace)
            } else {
                self
            }
        }
    }
}

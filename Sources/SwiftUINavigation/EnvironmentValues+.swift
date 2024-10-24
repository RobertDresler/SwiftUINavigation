import SwiftUI

private struct WrappedCustomNavigationStackNamespace: EnvironmentKey {
    static let defaultValue: Namespace.ID? = nil
}

public extension EnvironmentValues {
    var wrappedCustomNavigationStackNamespace: Namespace.ID? {
        get { self[WrappedCustomNavigationStackNamespace.self] }
        set { self[WrappedCustomNavigationStackNamespace.self] = newValue }
    }
}

extension View {
    func wrappedCustomNavigationStackNamespace(_ namespace: Namespace.ID) -> some View {
        environment(\.wrappedCustomNavigationStackNamespace, namespace)
    }
}

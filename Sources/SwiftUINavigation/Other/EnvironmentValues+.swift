import SwiftUI

private struct StackNavigationNamespace: EnvironmentKey {
    static let defaultValue: Namespace.ID? = nil
}

public extension EnvironmentValues {
    var stackNavigationNamespace: Namespace.ID? {
        get { self[StackNavigationNamespace.self] }
        set { self[StackNavigationNamespace.self] = newValue }
    }
}

extension View {
    func stackNavigationNamespace(_ namespace: Namespace.ID?) -> some View {
        Group {
            if let namespace {
                environment(\.stackNavigationNamespace, namespace)
            } else {
                self
            }
        }
    }
}

private struct RegisteredCustomPresentableNavigationNodes: EnvironmentKey {
    static let defaultValue: [any PresentedNavigationNode.Type] = []
}

public extension EnvironmentValues {
    var registeredCustomPresentableNavigationNodes: [any PresentedNavigationNode.Type] {
        get { self[RegisteredCustomPresentableNavigationNodes.self] }
        set { self[RegisteredCustomPresentableNavigationNodes.self] = newValue }
    }
}

extension View {
    func registerCustomPresentableNavigationNodes(_ nodes: [any PresentedNavigationNode.Type]) -> some View {
        environment(\.registeredCustomPresentableNavigationNodes, nodes)
    }
}

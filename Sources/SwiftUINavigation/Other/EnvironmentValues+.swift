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

public extension View {
    func registerCustomPresentableNavigationNodes(_ nodes: [any PresentedNavigationNode.Type]) -> some View {
        environment(\.registeredCustomPresentableNavigationNodes, nodes)
    }
}

private struct NavigationEnvironmentTriggerHandler: EnvironmentKey {
    static let defaultValue: DefaultNavigationEnvironmentTriggerHandler = DefaultNavigationEnvironmentTriggerHandler()
}

public extension EnvironmentValues {
    var navigationEnvironmentTriggerHandler: DefaultNavigationEnvironmentTriggerHandler {
        get { self[NavigationEnvironmentTriggerHandler.self] }
        set { self[NavigationEnvironmentTriggerHandler.self] = newValue }
    }
}

public extension View {
    func navigationEnvironmentTriggerHandler(_ handler: DefaultNavigationEnvironmentTriggerHandler) -> some View {
        environment(\.navigationEnvironmentTriggerHandler, handler)
    }
}

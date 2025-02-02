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

private struct RegisteredCustomPresentableNavigationModels: EnvironmentKey {
    static let defaultValue: [any PresentedNavigationModel.Type] = []
}

public extension EnvironmentValues {
    var registeredCustomPresentableNavigationModels: [any PresentedNavigationModel.Type] {
        get { self[RegisteredCustomPresentableNavigationModels.self] }
        set { self[RegisteredCustomPresentableNavigationModels.self] = newValue }
    }
}

public extension View {
    func registerCustomPresentableNavigationModels(_ models: [any PresentedNavigationModel.Type]) -> some View {
        environment(\.registeredCustomPresentableNavigationModels, models)
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

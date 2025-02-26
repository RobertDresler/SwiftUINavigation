import SwiftUI

public extension EnvironmentValues {
    @Entry var stackNavigationNamespace: Namespace.ID?
    @Entry var registeredCustomPresentableNavigationModels = [any PresentedNavigationModel.Type]()
    @Entry var navigationEnvironmentTriggerHandler = DefaultNavigationEnvironmentTriggerHandler()
    @Entry var customDismiss: (() -> Void)?
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

    public func registerCustomPresentableNavigationModels(_ models: [any PresentedNavigationModel.Type]) -> some View {
        environment(\.registeredCustomPresentableNavigationModels, models)
    }

    public func navigationEnvironmentTriggerHandler(_ handler: DefaultNavigationEnvironmentTriggerHandler) -> some View {
        environment(\.navigationEnvironmentTriggerHandler, handler)
    }

    public func customDismiss(_ handler: @escaping () -> Void) -> some View {
        environment(\.customDismiss, handler)
    }
}

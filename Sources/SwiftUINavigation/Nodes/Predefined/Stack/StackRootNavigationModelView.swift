import SwiftUI

public struct StackRootNavigationModelView<InputNavigationModel: StackRootNavigationModel>: View {

    @Namespace private var namespace
    @EnvironmentNavigationModel private var navigationModel: InputNavigationModel

    // MARK: Getters

    public init() {}

    public var body: some View {
        NavigationStack(path: path) {
            navigationStackResolvedRoot
        }
            .stackNavigationNamespace(namespace)
            .handlingStackTabBarToolbarBehavior(inputNavigationModelType: InputNavigationModel.self)
            /// This is needed for macOS since there seems to bug in the OS
            #if os(macOS)
            .onChange(of: path.wrappedValue) { path.wrappedValue = $0 }
            #endif
    }

    private var path: Binding<[StackNavigationDestination]> {
        Binding(
            get: { navigationPath },
            set: { setNewPath($0) }
        )
    }

    private var navigationStackResolvedRoot: some View {
        Group {
            if let rootModel = navigationModel.stackModels.first?.destination {
                NavigationModelResolvedView(model: rootModel)
                    .connectingNavigationDestinationLogic(
                        modelForModelID: { model(for: $0) },
                        namespace: namespace
                    )
            }
        }
    }

    private func model(for modelID: String) -> (any NavigationModel)? {
        stackModels.first(where: { model in
            modelID == model.destination.id
        })?.destination
    }

    private var navigationPath: [StackNavigationDestination] {
        var stackModels = stackModels
        guard !stackModels.isEmpty else { return [] }
        stackModels.removeFirst() /// Because first is root
        return stackModels.map { model in
            StackNavigationDestination(
                modelID: model.destination.id,
                transition: model.transition
            )
        }
    }

    private var stackModels: [StackNavigationModel] {
        navigationModel.stackModels
    }

    // MARK: Methods

    private func setNewPath(_ newPath: [StackNavigationDestination]) {
        navigationModel.setNewPath(newPath)
    }

}

// MARK: View+

fileprivate extension View {
    func connectingNavigationDestinationLogic(
        modelForModelID: @escaping (String) -> (any NavigationModel)?,
        namespace: Namespace.ID?
    ) -> some View {
        navigationDestination(for: StackNavigationDestination.self) { data in
            Group {
                if let model = modelForModelID(data.modelID) {
                    NavigationModelResolvedView(model: model)
                        .destinationWithNavigationTransition(transition: data.transition, namespace: namespace)
                }
            }
        }
    }

    @ViewBuilder
    func destinationWithNavigationTransition(
        transition: StackNavigationTransition?,
        namespace: Namespace.ID?
    ) -> some View {
        if #available(iOS 18.0, macOS 15.0, *), let namespace, let transition {
            navigationTransition(AnyNavigationTransition(transition.toNavigationTransition(in: namespace)))
        } else {
            self
        }
    }
}

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
    }

    private var path: Binding<NavigationPath> {
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

    private var navigationPath: NavigationPath {
        var stackModels = stackModels
        guard !stackModels.isEmpty else { return NavigationPath() }
        stackModels.removeFirst() /// Because first is root
        return NavigationPath(
            stackModels.compactMap { model in
                StackNavigationDestination(
                    modelID: model.destination.id,
                    transition: model.transition
                )
            }
        )
    }

    private var stackModels: [StackNavigationModel] {
        navigationModel.stackModels
    }

    // MARK: Methods

    private func setNewPath(_ newPath: NavigationPath) {
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

    func destinationWithNavigationTransition(
        transition: StackNavigationTransition?,
        namespace: Namespace.ID?
    ) -> some View {
        Group {
            if #available(iOS 18.0, *), let namespace {
                switch transition {
                case .zoom(let sourceID):
                    navigationTransition(.zoom(sourceID: sourceID, in: namespace))
                case nil:
                    self
                }
            } else {
                self
            }
        }
    }
}

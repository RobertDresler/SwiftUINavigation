import SwiftUI

public struct TabsRootNavigationModelView<InputNavigationModel: TabsRootNavigationModel>: View {

    @EnvironmentNavigationModel private var navigationModel: InputNavigationModel

    public init() {}

    public var body: some View {
        TabView(selection: selection) {
            ForEach(navigationModel.tabsModels, id: \.id) { model in
                let id = model.id
                model.resolvedView
                    .onAppear { handleOnAppear(for: id) }
            }
        }
    }

    /// This is known workaround for macOS Catalyst since there seems to be bug in the OS itself
    /// https://developer.apple.com/forums/thread/765619
    private func handleOnAppear(for modelID: AnyHashable) {
        if ProcessInfo.processInfo.isMacCatalystApp {
            selection.wrappedValue = modelID
        }
    }

    private var selection: Binding<AnyHashable> {
        Binding(
            get: { navigationModel.selectedTabModelID },
            set: { navigationModel.selectedTabModelID = $0 }
        )
    }

}

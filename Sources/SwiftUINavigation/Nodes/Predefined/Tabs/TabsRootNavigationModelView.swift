import SwiftUI

public struct TabsRootNavigationModelView<InputNavigationModel: TabsRootNavigationModel>: View {

    @EnvironmentNavigationModel private var navigationModel: InputNavigationModel

    public init() {}

    public var body: some View {
        TabView(selection: selection) {
            ForEach(navigationModel.tabsModels, id: \.id) { model in
                model.resolvedView
            }
        }
    }

    private var selection: Binding<AnyHashable> {
        Binding(
            get: { navigationModel.selectedTabModelID },
            set: { navigationModel.selectedTabModelID = $0 }
        )
    }

}

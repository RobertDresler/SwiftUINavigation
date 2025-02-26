import SwiftUI

public struct SwitchedNavigationModelView<InputNavigationModel: SwitchedNavigationModel>: View {

    @EnvironmentNavigationModel private var navigationModel: InputNavigationModel

    public init() {}

    public var body: some View {
        Group {
            if let switchedModel = navigationModel.switchedModel {
                NavigationModelResolvedView(model: switchedModel)
                    .id(switchedModel.id)
            } else {
                Color.clear
            }
        }
    }

}

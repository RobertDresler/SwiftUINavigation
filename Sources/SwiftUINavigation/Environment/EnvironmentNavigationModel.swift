import SwiftUI

@MainActor
@propertyWrapper
public struct EnvironmentNavigationModel<Model: NavigationModel>: DynamicProperty {

    @EnvironmentObject private var model: AnyNavigationModel

    public init() {}

    public var wrappedValue: Model {
        guard let model = model.base as? Model else { fatalError("Model in this environment should be of type \(type(of: Model.self))") }
        return model
    }

}

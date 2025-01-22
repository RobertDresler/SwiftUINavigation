import SwiftUI

@MainActor
@propertyWrapper
public struct EnvironmentNavigationNodeState<State: NavigationNodeState>: DynamicProperty {

    @EnvironmentObject private var node: AnyNavigationNode

    public init() {}

    public var wrappedValue: State {
        guard let state = node.base.state as? State else { fatalError("State in this environment should be of type \(type(of: State.self))") }
        return state
    }

}

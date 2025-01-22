import SwiftUI

@MainActor
@propertyWrapper
public struct EnvironmentNavigationNode<Node: NavigationNode>: DynamicProperty {

    @EnvironmentObject private var node: AnyNavigationNode

    public init() {}

    public var wrappedValue: Node {
        guard let node = node.base as? Node else { fatalError("Node in this environment should be of type \(type(of: Node.self))") }
        return node
    }

}

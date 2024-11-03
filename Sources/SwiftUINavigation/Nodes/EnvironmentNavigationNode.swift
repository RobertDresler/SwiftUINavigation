import SwiftUI

@MainActor
@propertyWrapper
public struct EnvironmentNavigationNode<Node: SwiftUINavigationNode>: DynamicProperty {

    @EnvironmentObject private var node: SwiftUINavigationNode

    public init() {}

    public var wrappedValue: Node {
        guard let node = node as? Node else { fatalError("Node in this environment should be of type \(type(of: Node.self))") }
        return node
    }

}

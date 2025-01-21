import SwiftUINavigation
import Foundation

public struct SegmentedTab: Hashable, Identifiable {

    public let id: String
    let name: String
    let node: NavigationNode

    public init(id: String = UUID().uuidString, name: String, node: NavigationNode) {
        self.id = id
        self.name = name
        self.node = node
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: SegmentedTab, rhs: SegmentedTab) -> Bool {
        lhs.id == rhs.id
    }

}

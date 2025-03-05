import SwiftUINavigation
import Foundation

public struct SegmentedTab: Hashable, Identifiable {

    public let id: String
    let name: String
    let model: any NavigationModel

    public init(id: String = UUID().uuidString, name: String, model: any NavigationModel) {
        self.id = id
        self.name = name
        self.model = model
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: SegmentedTab, rhs: SegmentedTab) -> Bool {
        lhs.id == rhs.id
    }

}

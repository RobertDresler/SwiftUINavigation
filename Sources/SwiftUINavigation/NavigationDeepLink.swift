public protocol NavigationDeepLink: Hashable {
    var instanceID: String { get }
    var debugName: String? { get }
}

// MARK: Default Implementations

public extension NavigationDeepLink {
    var debugName: String? { nil }
}

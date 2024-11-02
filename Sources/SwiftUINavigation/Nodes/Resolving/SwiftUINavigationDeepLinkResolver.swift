import SwiftUI

@MainActor
public protocol SwiftUINavigationDeepLinkResolver: ObservableObject {
    associatedtype DeepLink: NavigationDeepLink
    associatedtype ResolvedView: View
    func resolve(_ deepLink: DeepLink) -> ResolvedView // TODO: -RD- implement , messageCallback: @escaping (SwiftUINavigationMessage) -> Void
}

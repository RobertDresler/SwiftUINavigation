import SwiftUI

@MainActor
public protocol SwiftUINavigationDeepLinkResolver: ObservableObject {
    associatedtype DeepLink: NavigationDeepLink
    associatedtype ContentView: View
    func resolve(_ deepLink: DeepLink) -> ContentView

}

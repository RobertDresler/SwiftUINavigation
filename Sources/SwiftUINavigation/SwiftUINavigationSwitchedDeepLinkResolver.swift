import SwiftUI
import Combine

public protocol SwiftUINavigationSwitchedDeepLinkResolver<DeepLink>: ObservableObject {
    associatedtype DeepLink: NavigationDeepLink
    var switchedDeepLink: CurrentValueSubject<DeepLink?, Never> { get }
}

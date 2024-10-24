import SwiftUI

public final class SwiftUINavigationGraphNode<DeepLink: NavigationDeepLink>: ObservableObject {

    // TODO: -RD- move
    public enum Command {
        case append(AppendDeepLink<DeepLink>)
        case removeLast(count: Int = 1)
        case removeAll
        case alert(AlertConfig)
        case presentSheet(DeepLink)
        case dismiss
        case setRoot(DeepLink, clear: Bool)
        case switchNode(DeepLink)
    }

    @Published public var wrappedDeepLink: DeepLink?
    @Published var path = NavigationPath()
    // TODO: -RD- separate alert since it's not modal
    @Published var alertConfig: AlertConfig?
    @Published public var presentedSheetNode: SwiftUINavigationGraphNode<DeepLink>?
    @Published public var switchedNode: SwiftUINavigationGraphNode<DeepLink>?

    private var _openURL: ((URL) -> Void)?

    public weak var parent: SwiftUINavigationGraphNode<DeepLink>?

    init(wrappedDeepLink: DeepLink?, parent: SwiftUINavigationGraphNode<DeepLink>?) {
        self.wrappedDeepLink = wrappedDeepLink
        self.parent = parent
    }

    public func setOpenURL(_ openURL: @escaping (URL) -> Void) {
        self._openURL = openURL
    }

    public func append(_ value: AppendDeepLink<DeepLink>) {
        self.path.append(value)
    }

    public func presentSheet(_ value: DeepLink) {
        presentedSheetNode = SwiftUINavigationGraphNode(wrappedDeepLink: value, parent: self)
    }

    public func dismiss() {
        if presentedSheetNode != nil {
            presentedSheetNode = nil
        } else {
            parent?.dismiss()
        }
    }

    public func removeLast(_ count: Int = 1) {
        path.removeLast(count)
    }

    public func removeAll() {
        path = NavigationPath()
    }

    public func showAlert(_ config: AlertConfig) {
        alertConfig = config
    }

    public func openURL(_ url: URL) {
        _openURL?(url)
    }

    public func setRoot(_ root: DeepLink, clear: Bool) {
        self.wrappedDeepLink = root
        if clear {
            path = NavigationPath()
        }
    }

    func switchNode(_ deepLink: DeepLink) {
        switchedNode = SwiftUINavigationGraphNode(wrappedDeepLink: deepLink, parent: self)
    }

    public func executeCommand(_ command: Command) {
        switch command {
        case .append(let destination):
            append(destination)
        case .removeLast(let count):
            removeLast(count)
        case .removeAll:
            removeAll()
        case .alert(let config):
            alertConfig = config
        case .presentSheet(let destination):
            presentSheet(destination)
        case .dismiss:
            dismiss()
        case let .setRoot(deepLink, clear):
            setRoot(deepLink, clear: clear)
        case .switchNode(let deepLink):
            switchNode(deepLink)
        }
    }

}

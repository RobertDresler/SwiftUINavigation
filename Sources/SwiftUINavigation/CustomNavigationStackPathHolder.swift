import SwiftUI

public final class CustomNavigationStackPathHolder<Destination: NavigationDeepLink>: ObservableObject {

    public enum Command {
        case append(AppendDestination<Destination>)
        case removeLast(count: Int = 1)
        case removeAll
        case alert(AlertConfig)
        case presentSheet(Destination)
        case dismiss
        case setRoot(Destination)
    }

    @Published var root: Destination
    @Published var path = NavigationPath()
    @Published var alertConfig: AlertConfig?
    @Published var presentedSheetDestination: Destination?

    private var _openURL: ((URL) -> Void)?

    private weak var parent: CustomNavigationStackPathHolder<Destination>?

    init(root: Destination, parent: CustomNavigationStackPathHolder<Destination>?) {
        self.root = root
        self.parent = parent
    }

    public func setOpenURL(_ openURL: @escaping (URL) -> Void) {
        self._openURL = openURL
    }

    public func append(_ value: AppendDestination<Destination>) {
        self.path.append(value)
    }

    public func presentSheet(_ value: Destination) {
        presentedSheetDestination = value
    }

    public func dismiss() {
        if presentedSheetDestination != nil {
            presentedSheetDestination = nil
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

    public func setRoot(_ root: Destination) {
        self.root = root
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
        case .setRoot(let destination):
            setRoot(destination)
        }
    }

}

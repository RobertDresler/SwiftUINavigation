import SwiftUI

public final class CustomNavigationStackPathHolder<Destination: NavigationDeepLink>: ObservableObject {

    public enum Command {
        case append(Destination)
        case removeLast(count: Int = 1)
        case removeAll
        case alert(AlertConfig)
        case presentSheet(Destination)
        case dismissSheet
    }

    @Published var path = NavigationPath()
    @Published var alertConfig: AlertConfig?
    @Published var presentedSheetDestination: Destination?

    private var parentPathHolder: CustomNavigationStackPathHolder<Destination>?
    private var _openURL: ((URL) -> Void)?

    public func setParentPathHolder(parentPathHolder: CustomNavigationStackPathHolder<Destination>?) {
        self.parentPathHolder = parentPathHolder
    }

    public func setOpenURL(_ openURL: @escaping (URL) -> Void) {
        self._openURL = openURL
    }

    public func append(_ value: Destination) {
        self.path.append(value)
    }

    public func presentSheet(_ value: Destination) {
        presentedSheetDestination = value
    }

    public func dismissSheet() {
        presentedSheetDestination = nil
    }

    public func dismissSelfAsSheet() {
        parentPathHolder?.dismissSheet()
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
        case .dismissSheet:
            dismissSheet()
        }
    }

}

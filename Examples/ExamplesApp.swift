import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

@main
struct ExamplesApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    private let dependencies: Dependencies

    init() {
        dependencies = Dependencies()
        delegate.configure(
            notificationCenter: dependencies.notificationCenter,
            deepLinkForwarderService: dependencies.deepLinkForwarderService
        )
        NavigationConfig.shared.isDebugPrintEnabled = true
    }

    var body: some Scene {
        WindowGroup {
            AppWindow(dependencies: dependencies)
        }
        WindowGroup(id: WindowID.waiting.rawValue) {
            WaitingWindow(dependencies: dependencies)
        }
    }

}

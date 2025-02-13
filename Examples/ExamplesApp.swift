import SwiftUI
import SwiftUINavigation
import Shared

@main
struct ExamplesApp: App {

    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #else
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    #endif
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

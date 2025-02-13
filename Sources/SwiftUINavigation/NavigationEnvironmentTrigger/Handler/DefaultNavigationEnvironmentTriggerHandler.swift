import SwiftUI

open class DefaultNavigationEnvironmentTriggerHandler: @unchecked Sendable {

    @MainActor
    open func handleTrigger(_ trigger: NavigationEnvironmentTrigger, in environment: EnvironmentValues) {
        if let openURLTrigger = trigger as? OpenURLNavigationEnvironmentTrigger {
            environment.openURL(openURLTrigger.url)
        } else if let openWindowTrigger = trigger as? OpenWindowNavigationEnvironmentTrigger {
            environment.openWindow(id: openWindowTrigger.id)
        } else if #available(iOS 17.0, macOS 14.0, *), let dismissWindowTrigger = trigger as? DismissWindowNavigationEnvironmentTrigger {
            environment.dismissWindow(id: dismissWindowTrigger.id)
        } else if trigger is DismissNavigationEnvironmentTrigger {
            environment.dismiss()
        } else {
            print("Unknown trigger: \(trigger)")
        }
    }

    public init() {}

}

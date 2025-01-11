import SwiftUI

@MainActor
open class DefaultNavigationEnvironmentTriggerHandler {

    open func handleTrigger(_ trigger: NavigationEnvironmentTrigger, in environment: EnvironmentValues) {
        if let openURLTrigger = trigger as? OpenURLNavigationEnvironmentTrigger {
            environment.openURL(openURLTrigger.url)
        } else if let openWindowTrigger = trigger as? OpenWindowNavigationEnvironmentTrigger {
            environment.openWindow(id: openWindowTrigger.id)
        } else if #available(iOS 17, *), let dismissWindowTrigger = trigger as? DismissWindowNavigationEnvironmentTrigger {
            environment.dismissWindow(id: dismissWindowTrigger.id)
        } else if let dismissTrigger = trigger as? DismissNavigationEnvironmentTrigger {
            environment.dismiss()
        } else {
            print("Unknown trigger: \(trigger)")
        }
    }

}

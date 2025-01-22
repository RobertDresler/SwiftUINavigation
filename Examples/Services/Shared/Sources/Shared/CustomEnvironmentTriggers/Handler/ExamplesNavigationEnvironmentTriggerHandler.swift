import SwiftUINavigation
import SwiftUI

public final class ExamplesNavigationEnvironmentTriggerHandler: DefaultNavigationEnvironmentTriggerHandler, @unchecked Sendable {

    public override func handleTrigger(_ trigger: NavigationEnvironmentTrigger, in environment: EnvironmentValues) {
        if trigger is RequestReviewNavigationEnvironmentTrigger {
            /// Due to SwiftUI limitations, `requestReview` action cannot be called directly (`environment.requestReview()`)  and needs to be proxied (see `AppWindow` for reference).
            environment.requestReviewProxy?()
        } else {
            super.handleTrigger(trigger, in: environment)
        }
    }

}

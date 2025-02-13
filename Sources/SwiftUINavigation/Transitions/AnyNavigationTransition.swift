import SwiftUI

@available(iOS 18.0, macOS 15.0, *)
struct AnyNavigationTransition: NavigationTransition {

    func _outputs(for inputs: _NavigationTransitionInputs) -> _NavigationTransitionOutputs {
        transition._outputs(for: inputs)
    }

    let transition: any NavigationTransition

    init(_ transition: any NavigationTransition) {
        self.transition = transition
    }

}

import SwiftUINavigation
import Foundation

public struct ShowAndHideAfterDelayNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        executablePresentCommand(on: model).execute(on: model)
        let hideDelay = hideDelay
        let animated = animated
        let hidePresentedModel = { @MainActor [weak presentedModel = presentedModel.model] in
            presentedModel?.execute(.dismiss(animated: animated))
        }
        Task {
            try? await Task.sleep(nanoseconds: UInt64(hideDelay * 1_000_000_000))
            hidePresentedModel()
        }
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        executablePresentCommand(on: model).canExecute(on: model)
    }

    private let presentedModel: any PresentedNavigationModel
    private let hideDelay: TimeInterval
    private let animated: Bool

    public init(presentedModel: any PresentedNavigationModel, hideDelay: TimeInterval, animated: Bool = true) {
        self.presentedModel = presentedModel
        self.hideDelay = hideDelay
        self.animated = animated
    }

    private func executablePresentCommand(on model: any NavigationModel) -> NavigationCommand {
        .present(presentedModel, animated: animated)
    }

}

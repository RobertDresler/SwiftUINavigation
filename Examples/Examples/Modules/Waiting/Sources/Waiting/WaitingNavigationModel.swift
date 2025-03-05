import SwiftUINavigation
import SwiftUI
import Shared

@NavigationModel
public final class WaitingNavigationModel {

    private let flagsRepository: FlagsRepository

    public init(flagsRepository: FlagsRepository) {
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        WaitingView()
    }

    func close() {
        flagsRepository.isWaitingWindowOpen = false
        if #available(iOS 17, *) {
            /// On iOS 17 you can dismiss certain window from any window, see `AppNavigationModel`
        } else {
            execute(.dismissWindow(id: WindowID.waiting.rawValue))
        }
    }

}

import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

public final class WaitingNavigationNode: NavigationNode {

    private let inputData: WaitingInputData
    private let flagsRepository: FlagsRepository

    public init(inputData: WaitingInputData, flagsRepository: FlagsRepository) {
        self.inputData = inputData
        self.flagsRepository = flagsRepository
        super.init()
    }

    public override var view: AnyView {
        AnyView(WaitingView(inputData: inputData))
    }

    func close() {
        flagsRepository.isWaitingWindowOpen = false
        if #available(iOS 17, *) {
            /// On iOS 17 you can dismiss certain window from any window, see `AppNavigationNode`
        } else {
            executeCommand(DismissWindowNavigationCommand(id: WindowID.waiting.rawValue))
        }
    }

}

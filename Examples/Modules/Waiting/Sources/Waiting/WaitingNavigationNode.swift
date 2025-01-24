import SwiftUINavigation
import ExamplesNavigation
import SwiftUI
import FlagsRepository

@NavigationNode
public final class WaitingNavigationNode {

    private let inputData: WaitingInputData
    private let flagsRepository: FlagsRepository

    public init(inputData: WaitingInputData, flagsRepository: FlagsRepository) {
        self.inputData = inputData
        self.flagsRepository = flagsRepository
    }

    public var body: some View {
        WaitingView(inputData: inputData)
    }

    func close() {
        flagsRepository.isWaitingWindowOpen = false
        if #available(iOS 17, *) {
            /// On iOS 17 you can dismiss certain window from any window, see `AppNavigationNode`
        } else {
            execute(.dismissWindow(id: WindowID.waiting.rawValue))
        }
    }

}

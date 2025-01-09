import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

public final class CommandsGalleryNavigationNode: NavigationNode {

    private let inputData: CommandsGalleryInputData

    public init(inputData: CommandsGalleryInputData) {
        self.inputData = inputData
        super.init()
    }

    @MainActor
    public override var view: AnyView {
        AnyView(CommandsGalleryView(inputData: inputData))
    }

}


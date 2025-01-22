import SwiftUI
import Combine

@NavigationNode
final class AlertNavigationNode {

    var body: EmptyView {
        EmptyView()
    }
    
    let inputData: AlertInputData

    init(inputData: AlertInputData) {
        self.inputData = inputData
    }

}


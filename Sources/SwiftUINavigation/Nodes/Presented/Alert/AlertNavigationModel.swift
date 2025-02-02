import SwiftUI
import Combine

@NavigationModel
final class AlertNavigationModel {

    var body: EmptyView {
        EmptyView()
    }
    
    let inputData: AlertInputData

    init(inputData: AlertInputData) {
        self.inputData = inputData
    }

}


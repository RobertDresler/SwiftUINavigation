import SwiftUI
import Combine

public final class CommonNavigationModelState: ObservableObject {

    let id: String = UUID().uuidString
    @Published var presentedModel: (any PresentedNavigationModel)?
    var didStart = false
    var didFinish = false
    weak var parent: (any NavigationModel)? {
        didSet { objectWillChange.send() }
    }
    var messageListeners = [NavigationMessageListener]()
    let navigationEnvironmentTrigger = PassthroughSubject<NavigationEnvironmentTrigger, Never>()
    var cancellables = Set<AnyCancellable>()

    public init() {}

}

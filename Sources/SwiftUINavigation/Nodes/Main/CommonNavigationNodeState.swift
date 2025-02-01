import SwiftUI
import Combine

public final class CommonNavigationNodeState: ObservableObject {

    let id: String = UUID().uuidString
    @Published var presentedNode: (any PresentedNavigationNode)?
    var didStart = false
    var didFinish = false
    weak var parent: (any NavigationNode)? {
        didSet { objectWillChange.send() }
    }
    var messageListeners = [NavigationMessageListener]()
    let navigationEnvironmentTrigger = PassthroughSubject<NavigationEnvironmentTrigger, Never>()
    var cancellables = Set<AnyCancellable>()

    public init() {}

}

import SwiftUI
import Combine

open class NavigationNodeState: ObservableObject {

    // MARK: Published

    @MainActor @Published public var presentedNode: (any PresentedNavigationNode)?

    // MARK: Stored

    public let id: String = UUID().uuidString
    weak var parent: (any NavigationNode)? {
        didSet { objectWillChange.send() }
    }
    var cancellables = Set<AnyCancellable>()
    var _defaultDeepLinkHandler: NavigationDeepLinkHandler?
    var messageListeners = [NavigationMessageListener]()
    var debugPrintPrefix: String?
    let _childrenPublisher = CurrentValueSubject<[any NavigationNode], Never>([])
    let navigationEnvironmentTrigger = PassthroughSubject<NavigationEnvironmentTrigger, Never>()

    var didStart = false
    var didFinish = false

    // MARK: Getters

    @MainActor open var children: [any NavigationNode] {
        [presentedNode?.node].compactMap { $0 }
    }

    @MainActor var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.state.defaultDeepLinkHandler
    }

    // MARK: Lifecycle

    public init() {}

    deinit {
        printDebugText("Finished")
    }

    // MARK: Internal Methods

    @MainActor func bind(with thisStateNode: any NavigationNode) {
        debugPrintPrefix = "[\(type(of: thisStateNode)) \(id.prefix(3))...]"
    }

    func addMessageListener(_ listener: NavigationMessageListener?) {
        guard let listener else { return }
        messageListeners.append(listener)
    }

    func sendMessage(_ message: NavigationMessage) {
        messageListeners.forEach { listener in
            listener(message)
        }
    }

    func sendEnvironmentTrigger(_ trigger: NavigationEnvironmentTrigger) {
        navigationEnvironmentTrigger.send(trigger)
    }

    nonisolated
    func printDebugText(_ text: String) {
        guard let debugPrintPrefix else { return }
        Task { @MainActor in
            guard NavigationConfig.shared.isDebugPrintEnabled else { return }
            print("\(debugPrintPrefix): \(text)")
        }
    }

    @MainActor func printDebugGraphFromExactNode(level: Int = 0) {
        guard let debugPrintPrefix else { return }
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugPrintPrefix)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.state.printDebugGraphFromExactNode(level: level + 1)
            }
        }
    }

}

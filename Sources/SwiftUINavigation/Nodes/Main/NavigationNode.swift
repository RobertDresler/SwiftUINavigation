import SwiftUI
import Combine

@MainActor public protocol NavigationNode: ObservableObject, NavigationCommandExecuter {
    associatedtype Body: View
    @ViewBuilder var body: Body { get }
    nonisolated var id: String { get }
    var isWrapperNode: Bool { get }
    var commonState: CommonNavigationNodeState { get }
    var parent: (any NavigationNode)? { get }
    var children: [any NavigationNode] { get }
    var presentedNode: (any PresentedNavigationNode)? { get set }
    func startIfNeeded(parent: (any NavigationNode)?) async
    func finishIfNeeded()
}

// MARK: Default Implementations

public extension NavigationNode {
    var presentedNode: (any PresentedNavigationNode)? {
        get { commonState.presentedNode }
        set { commonState.presentedNode = newValue }
    }

    var parent: (any NavigationNode)? {
        commonState.parent
    }

    var isWrapperNode: Bool {
        true
    }

    var children: [any NavigationNode] {
        baseNavigationNodeChildren
    }

    var baseNavigationNodeChildren: [any NavigationNode] {
        [presentedNode].compactMap { $0?.node }
    }

    func startIfNeeded(parent: (any NavigationNode)?) async {
        guard !commonState.didStart else { return }
        commonState.didStart = true
        await start(parent: parent)
        printDebugText("Started")
    }

    func finishIfNeeded() {
        guard !commonState.didFinish else { return }
        commonState.didFinish = true
        finish()
    }
}

// MARK: Public Methods

public extension NavigationNode {
    nonisolated func printDebugText(_ text: String) {
        let printText = "\(debugPrintPrefix): \(text)"
        Task { @MainActor in
            guard NavigationConfig.shared.isDebugPrintEnabled else { return }
            print(printText)
        }
    }

    func printDebugGraph() {
        root.printDebugGraphFromExactNode()
    }

    func addMessageListener(_ listener: NavigationMessageListener?) {
        guard let listener else { return }
        commonState.messageListeners.append(listener)
    }

    func sendMessage(_ message: NavigationMessage) {
        commonState.messageListeners.forEach { listener in
            listener(message)
        }
    }

    func sendEnvironmentTrigger(_ trigger: NavigationEnvironmentTrigger) {
        commonState.navigationEnvironmentTrigger.send(trigger)
    }

    func onMessageReceived(_ listener: NavigationMessageListener?) -> Self {
        addMessageListener(listener)
        return self
    }
}

// MARK: Private Methods

private extension NavigationNode {
    nonisolated var debugPrintPrefix: String {
        "[\(type(of: self)) \(id.prefix(3))...]"
    }

    func printDebugGraphFromExactNode(level: Int = 0) {
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugPrintPrefix)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.printDebugGraphFromExactNode(level: level + 1)
            }
        }
    }

    func start(parent: (any NavigationNode)?) async {
        /// Binding like this is needed since withTransaction wouldn't work with that
        commonState
            .objectWillChange
            .sink { [weak self] in
                guard let publisher = self?.objectWillChange as? ObservableObjectPublisher else { return }
                publisher.send()
            }
            .store(in: &commonState.cancellables)
        await Task { @MainActor in /// This is needed since Publishing changes from within view updates is not allowed
            commonState.parent = parent
        }.value
    }

    func finish() {
        sendMessage(RemovalNavigationMessage())
    }
}

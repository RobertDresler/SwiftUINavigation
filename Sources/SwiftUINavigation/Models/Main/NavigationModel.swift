import SwiftUI
import Combine

@MainActor public protocol NavigationModel: ObservableObject, NavigationCommandExecuter {
    associatedtype Body: View
    @ViewBuilder var body: Body { get }
    nonisolated var id: String { get }
    var isWrapperModel: Bool { get }
    var commonState: CommonNavigationModelState { get }
    var parent: (any NavigationModel)? { get }
    var children: [any NavigationModel] { get }
    var presentedModel: (any PresentedNavigationModel)? { get set }
    func startIfNeeded(parent: (any NavigationModel)?) async
    func finishIfNeeded()
}

// MARK: Default Implementations

public extension NavigationModel {
    var presentedModel: (any PresentedNavigationModel)? {
        get { commonState.presentedModel }
        set { commonState.presentedModel = newValue }
    }

    var parent: (any NavigationModel)? {
        commonState.parent
    }

    var isWrapperModel: Bool {
        true
    }

    var children: [any NavigationModel] {
        baseNavigationModelChildren
    }

    var baseNavigationModelChildren: [any NavigationModel] {
        [presentedModel].compactMap { $0?.model }
    }

    func startIfNeeded(parent: (any NavigationModel)?) async {
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

public extension NavigationModel {
    nonisolated func printDebugText(_ text: String) {
        let printText = "\(debugPrintPrefix): \(text)"
        Task { @MainActor in
            guard NavigationConfig.shared.isDebugPrintEnabled else { return }
            print(printText)
        }
    }

    func printDebugGraph() {
        root.printDebugGraphFromExactModel()
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

private extension NavigationModel {
    nonisolated var debugPrintPrefix: String {
        "[\(type(of: self)) \(id.prefix(3))...]"
    }

    func printDebugGraphFromExactModel(level: Int = 0) {
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugPrintPrefix)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.printDebugGraphFromExactModel(level: level + 1)
            }
        }
    }

    func start(parent: (any NavigationModel)?) async {
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
        sendMessage(FinishedNavigationMessage())
    }
}

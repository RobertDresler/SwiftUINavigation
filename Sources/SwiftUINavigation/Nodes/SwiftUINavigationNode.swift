import SwiftUI
import Combine

public final class SwiftUINavigationNode<DeepLink: NavigationDeepLink>: ObservableObject {

    public enum Value {
        case deepLink(DeepLink)
        case stackRoot
    }

    public enum NodeType {
        case windowRoot
        case standalone
        case stackRoot
        case switchedNode
    }

    // TODO: -RD- separate
    public enum Command {
        case append(StackDeepLink<DeepLink>)
        case removeLast(count: Int = 1)
        case removeAll
        case alert(AlertConfig)
        case presentSheet(DeepLink)
        case dismiss
        case setRoot(DeepLink, clear: Bool)
        case switchNode(SwiftUINavigationNode<DeepLink>)
    }

    struct NodeStackDeepLink {

        let destination: SwiftUINavigationNode<DeepLink>
        let transition: StackDeepLink<DeepLink>.Transition?

        var toStackDeepLink: StackDeepLink<DeepLink>? {
            guard case .deepLink(let deepLink) = destination.value else { return nil }
            return StackDeepLink(destination: deepLink, transition: transition)
        }

    }

    @Published public var value: Value
    @Published var stackNodes: [NodeStackDeepLink]?
    @Published var tabsNodes: [SwiftUINavigationNode<DeepLink>]?
    // TODO: -RD- separate alert since it's not modal
    @Published var alertConfig: AlertConfig?
    @Published public var presentedSheetNode: SwiftUINavigationNode<DeepLink>?
    @Published public var switchedNode: SwiftUINavigationNode<DeepLink>?
    public var directChildNodeReference: SwiftUINavigationNode<DeepLink>?
    private var cancellables = Set<AnyCancellable>()
    private var _openURL: ((URL) -> Void)?

    public weak var parent: SwiftUINavigationNode<DeepLink>?
    let type: NodeType
    private var root: SwiftUINavigationNode<DeepLink> {
        parent?.root ?? self
    }

    public init(
        type: NodeType,
        value: Value,
        parent: SwiftUINavigationNode<DeepLink>?,
        stackNodes: [StackDeepLink<DeepLink>]? = nil
    ) {
        self.type = type
        self.value = value
        self.parent = parent
        self.stackNodes = stackNodes == nil ? nil : []
        switch value {
        case .deepLink(let deepLink):
            print("Init of node with deepLink instance ID: \(deepLink.instanceID)")
        case .stackRoot:
            print("Init of stackRoot node")
        }
        if let stackNodes {
            mapStackNodes { _ in stackNodes }
        }
        if [.windowRoot, .switchedNode].contains(parent?.type) {
            parent?.directChildNodeReference = self
        }

        NotificationCenter.default.publisher(for: Notification.Name(rawValue: "deviceDidShakeNotification"))
            .sink { [weak self] _ in
                self?.printDebugGraphFromExactNode()
            }
            .store(in: &cancellables)
    }

    deinit {
        switch value {
        case .deepLink(let deepLink):
            print("Deinit of node with deepLink instance ID: \(deepLink.instanceID)")
        case .stackRoot:
            print("Deinit of stackRoot node")
        }
    }

    public func setOpenURL(_ openURL: @escaping (URL) -> Void) {
        self._openURL = openURL
    }

    public func append(_ value: StackDeepLink<DeepLink>) {
        mapStackNodes { nodes in
            nodes + [value]
        }
    }

    public func presentSheet(_ value: DeepLink) {
        nearestNodeWhichCanPresent?.presentSheetOnExactNode(value)
    }

    public func dismiss() {
        if presentedSheetNode != nil {
            presentedSheetNode = nil
        } else {
            parent?.dismiss()
        }
    }

    public func removeLast(_ count: Int = 1) {
        // TODO: -RD- implement path.removeLast(count)
    }

    public func removeAll() {
        // TODO: -RD- implement path = NavigationPath()
    }

    public func showAlert(_ config: AlertConfig) {
        alertConfig = config
    }

    public func openURL(_ url: URL) {
        _openURL?(url)
    }

    public func setRoot(_ newRoot: DeepLink, clear: Bool) {
        let newRootStackDeepLink = StackDeepLink(destination: newRoot)
        mapStackNodes { nodes in
            if clear || nodes.isEmpty {
                return [newRootStackDeepLink]
            } else {
                var newNodes = nodes
                newNodes.removeFirst()
                return [newRootStackDeepLink] + newNodes
            }
        }
    }

    func mapStackNodes(mappedNodes: ([StackDeepLink<DeepLink>]) -> [StackDeepLink<DeepLink>]) {
        guard let stackNodes else {
            parent?.mapStackNodes(mappedNodes: mappedNodes)
            return
        }
        self.stackNodes = mappedNodes(
            stackNodes.compactMap { $0.toStackDeepLink }
        ).map { deepLink in
            NodeStackDeepLink(
                destination: SwiftUINavigationNode(type: .standalone, value: .deepLink(deepLink.destination), parent: self),
                transition: deepLink.transition
            )
        }
    }

    func switchNode(_ node: SwiftUINavigationNode<DeepLink>) {
        switchedNode = node
    }

    public func printDebugGraph() {
        root.printDebugGraphFromExactNode()
    }

    public func executeCommand(_ command: Command) {
        switch command {
        case .append(let destination):
            append(destination)
        case .removeLast(let count):
            removeLast(count)
        case .removeAll:
            removeAll()
        case .alert(let config):
            alertConfig = config
        case .presentSheet(let destination):
            presentSheet(destination)
        case .dismiss:
            dismiss()
        case let .setRoot(deepLink, clear):
            setRoot(deepLink, clear: clear)
        case .switchNode(let node):
            switchNode(node)
        }
    }

}

// MARK: Private Methods

private extension SwiftUINavigationNode {
    func presentSheetOnExactNode(_ value: DeepLink) {
        presentedSheetNode = SwiftUINavigationNode(
            type: .stackRoot,
            value: .stackRoot,
            parent: self,
            stackNodes: [StackDeepLink(destination: value)]
        )
    }
    var nearestNodeWhichCanPresent: SwiftUINavigationNode<DeepLink>? {
        nearestNodeWhichCanPresentFromParent?.topPresented
    }

    var topPresented: SwiftUINavigationNode<DeepLink> {
        presentedSheetNode?.topPresented ?? self
    }

    var nearestNodeWhichCanPresentFromParent: SwiftUINavigationNode<DeepLink>? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    var canPresentIfWouldnt: Bool {
        parent?.type != .stackRoot
    }

    var children: [SwiftUINavigationNode<DeepLink>] {
        (
            [directChildNodeReference]
            + [presentedSheetNode]
            + (stackNodes?.map(\.destination) ?? [])
        ).compactMap { $0 }
    }

    func printDebugGraphFromExactNode(level: Int = 0) {
        let indentation = Array(repeating: "\t", count: level).joined()
        print("\(indentation)<\(debugGraphNameForPrint)>")
        let children = children
        if !children.isEmpty {
            children.forEach { child in
                child.printDebugGraphFromExactNode(level: level + 1)
            }
        }
    }

    var debugGraphNameForPrint: String {
        switch value {
        case .deepLink(let deepLink):
            "\(type) - \(deepLink.debugName)"
        case .stackRoot:
            "\(type)"
        }
    }
}

import SwiftUI

/// Thanks to https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-shake-gestures
// The notification we'll send when a shake gesture happens.
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

//  Override the default behavior of shake gestures to send our notification instead.
extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}

// A view modifier that detects shaking and calls a function of our choosing.
struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}

// A View extension to make the modifier easier to use.
extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}

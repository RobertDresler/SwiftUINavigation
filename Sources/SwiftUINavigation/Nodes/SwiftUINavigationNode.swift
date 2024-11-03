import SwiftUI
import Combine

public final class SwiftUINavigationStackRootNode: SwiftUINavigationNode {

    private struct ViewWrapper: View {

        @Namespace private var namespace

        var body: some View {
            SwiftUINavigationStackNodeResolvedView()
                .wrappedNavigationStackNodeNamespace(namespace)
        }

    }

    @MainActor
    public override var view: AnyView {
        AnyView(ViewWrapper())
    }

    public init(stackNodes: [SwiftUINavigationNodeWithStackTransition]) {
        super.init(stackNodes: stackNodes)
    }

}

open class SwiftUINavigationNode: ObservableObject {

    // TODO: -RD- separate
    public enum Command {
        case append(SwiftUINavigationNodeWithStackTransition)
        case removeLast(count: Int = 1)
        case removeAll
        case alert(AlertConfig)
        case presentSheet(SwiftUINavigationNode)
        case dismiss
        case setRoot(SwiftUINavigationNode, clear: Bool)
        case switchNode(SwiftUINavigationNode)
        case openURL(URL)
    }

    @Published var stackNodes: [SwiftUINavigationNodeWithStackTransition]?
    @Published var tabsNodes: [SwiftUINavigationNode]?
    // TODO: -RD- separate alert since it's not modal
    @Published var alertConfig: AlertConfig?
    @Published public var presentedSheetNode: SwiftUINavigationNode?
    @Published public var switchedNode: SwiftUINavigationNode?
    public let urlToOpen = PassthroughSubject<URL, Never>()
    private var cancellables = Set<AnyCancellable>()
    public var defaultDeepLinkHandler: NavigationDeepLinkHandler? {
        _defaultDeepLinkHandler ?? parent?.defaultDeepLinkHandler
    }
    public var _defaultDeepLinkHandler: NavigationDeepLinkHandler?

    public weak var parent: SwiftUINavigationNode?
    private var root: SwiftUINavigationNode {
        parent?.root ?? self
    }

    public let id: String

    // TODO: -RD- make type more dependent on resolved view - e.g. if you want switched, subclass switched
    public init(
        stackNodes: [SwiftUINavigationNodeWithStackTransition]? = nil,
        defaultDeepLinkHandler: NavigationDeepLinkHandler? = nil
    ) {
        self.id = UUID().uuidString
        self.stackNodes = stackNodes == nil ? nil : []
        _defaultDeepLinkHandler = defaultDeepLinkHandler
        printDebugText("Init")
        if let stackNodes {
            mapStackNodes { _ in
                stackNodes
            }
        }
        bindParentLogic()
    }

    deinit {
        printDebugText("Deinit")
    }

    func bindParentLogic() {
        // TODO: @Published var tabsNodes: [SwiftUINavigationNode]?
        // TODO: -RD- merge
        $stackNodes
            .compactMap { $0 }
            .sink { [weak self] nodes in
                guard let self else { return }
                nodes.forEach { $0.destination.parent = self }
            }
            .store(in: &cancellables)

        $presentedSheetNode
            .compactMap { $0 }
            .sink { [weak self] node in
                guard let self else { return }
                node.parent = self
            }
            .store(in: &cancellables)

        $switchedNode
            .compactMap { $0 }
            .sink { [weak self] node in
                guard let self else { return }
                node.parent = self
            }
            .store(in: &cancellables)
    }

    private func printDebugText(_ text: String) {
        print("[\(type(of: self)) \(id)]: \(text)")
    }

    @MainActor
    open var view: AnyView {
        AnyView(EmptyView())
    }

    // TODO: -RD- make overridable
    public func handleDeepLink(_ deepLink: any NavigationDeepLink) {
        defaultDeepLinkHandler?.handleDeepLink(deepLink, on: self)
    }

    public func append(_ value: SwiftUINavigationNodeWithStackTransition) {
        mapStackNodes { nodes in
            nodes + [value]
        }
    }

    public func presentSheet(_ value: SwiftUINavigationNode) {
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
        urlToOpen.send(url)
    }

    public var canPresentIfWouldnt: Bool {
        (parent is SwiftUINavigationStackRootNode) == false
    }

    public func setRoot(_ newRoot: SwiftUINavigationNode, clear: Bool) {
        let newRootStackDeepLink = SwiftUINavigationNodeWithStackTransition(
            destination: newRoot,
            transition: nil
        )
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

    func mapStackNodes(
        mappedNodes: ([SwiftUINavigationNodeWithStackTransition]) -> [SwiftUINavigationNodeWithStackTransition]
    ) {
        guard let stackNodes else {
            parent?.mapStackNodes(mappedNodes: mappedNodes)
            return
        }
        self.stackNodes = mappedNodes(stackNodes)
    }

    func switchNode(_ node: SwiftUINavigationNode) {
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
        case let .setRoot(node, clear):
            setRoot(node, clear: clear)
        case .switchNode(let node):
            switchNode(node)
        case .openURL(let url):
            openURL(url)
        }
    }

}

// MARK: Private Methods

private extension SwiftUINavigationNode {
    func presentSheetOnExactNode(_ value: SwiftUINavigationNode) {
        presentedSheetNode = SwiftUINavigationStackRootNode(
            stackNodes: [SwiftUINavigationNodeWithStackTransition(destination: value, transition: nil)]
        )
    }
    var nearestNodeWhichCanPresent: SwiftUINavigationNode? {
        nearestNodeWhichCanPresentFromParent?.topPresented
    }

    var topPresented: SwiftUINavigationNode {
        presentedSheetNode?.topPresented ?? self
    }

    var nearestNodeWhichCanPresentFromParent: SwiftUINavigationNode? {
        if canPresentIfWouldnt {
            self
        } else {
            parent?.nearestNodeWhichCanPresentFromParent
        }
    }

    var children: [SwiftUINavigationNode] {
        (
            [presentedSheetNode]
            + [switchedNode]
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
        "\(id)" // TODO: -RD- update
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

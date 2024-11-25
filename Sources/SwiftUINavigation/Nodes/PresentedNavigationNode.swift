import SwiftUI
import PhotosUI

public struct PresentedNavigationNodeFullScreenCover: PresentedNavigationNode {

    public let node: NavigationNode

    init(node: NavigationNode) {
        self.node = node
    }

    public static func standalone(node: NavigationNode) -> Self {
        PresentedNavigationNodeFullScreenCover(node: node)
    }

    public static func stacked(node: NavigationNode) -> Self {
        PresentedNavigationNodeFullScreenCover(
            node: StackRootNavigationNode(
                stackNodes: [NavigationNodeWithStackTransition(destination: node, transition: nil)]
            )
        )
    }

    public static func presenterResolvedViewModifier(resolvedViewNode: NavigationNode, content: AnyView, id: String?) -> some View {
        content
            .fullScreenCover(
                isPresented: Binding(
                    get: {
                        if resolvedViewNode.presentedNode is Self, id == nil {
                            true
                        } else {
                            false
                        }
                    },
                    set: { isPresented in
                        guard !isPresented else { return }
                        resolvedViewNode.presentedNode = nil
                    }
                ),
                content: {
                    if let presentedNode = resolvedViewNode.presentedNode as? Self {
                        NavigationNodeResolvedView(node: presentedNode.node)
                    }
                }
            )
    }

}

public struct AlertSourceViewModifier: ViewModifier {

    @EnvironmentNavigationNode private var navigationNode

    let id: String

    public func body(content: Content) -> some View {
        modifyNodeViewWithPresentableNavigationNodes(content)
    }

    func modifyNodeViewWithPresentableNavigationNodes(_ view: some View) -> some View {
        [ConfirmationDialogPresentedNavigationNode.self].reduce(AnyView(view)) { resolvedView, modifier in
            AnyView(modifier.self.presenterResolvedViewModifier(resolvedViewNode: navigationNode, content: resolvedView, id: id))
        }
    }

}

public extension View {
    func presentingNavigationSource(id: String) -> some View {
        modifier(AlertSourceViewModifier(id: id))
    }

}

public struct AlertPresentedNavigationNode: PresentedNavigationNode {

    public let node: NavigationNode
    private let inputData: AlertInputData
    private let sourceID: String?

    public init(inputData: AlertInputData, sourceID: String? = nil) {
        self.node = AlertNavigationNode()
        self.inputData = inputData
        self.sourceID = sourceID
    }

    public static func presenterResolvedViewModifier(resolvedViewNode: NavigationNode, content: AnyView, id: String?) -> some View {
        content
           /* .photosPicker(
                isPresented: Binding(
                    get: {
                        if resolvedViewNode.presentedNode is Self {
                            true
                        } else {
                            false
                        }
                    },
                    set: { isPresented in
                        guard !isPresented else { return }
                        resolvedViewNode.presentedNode = nil
                    }
                ),
                selection: .constant(nil)
            )*/
            .confirmationDialog(
                Text("Testuju"),
                isPresented: Binding(
                    get: {
                        if resolvedViewNode.presentedNode is Self, id == (resolvedViewNode.presentedNode as? Self)?.sourceID {
                            true
                        } else {
                            false
                        }
                    },
                    set: { isPresented in
                        guard !isPresented else { return }
                        resolvedViewNode.presentedNode = nil
                    }
                ),
                actions: {
                    Button("Test", action: { print("tapped") })
                    Button("Test", action: { print("tapped") })
                }
            )
           /* .alert(
                Text((resolvedViewNode.presentedNode as? Self)?.inputData.title ?? ""),
                isPresented: Binding(
                    get: {
                        if resolvedViewNode.presentedNode is Self {
                            true
                        } else {
                            false
                        }
                    },
                    set: { isPresented in
                        guard !isPresented else { return }
                        resolvedViewNode.presentedNode = nil
                    }
                ),
                actions: {
                    Button("Test", action: { print("tapped") })
                },
                message: {
                    if let message = (resolvedViewNode.presentedNode as? Self)?.inputData.message {
                        Text(message)
                    }
                }
            )*/

    }

}

public struct ConfirmationDialogInputData: Hashable {

    public struct Action: Hashable {

        public enum Role {
            case cancel
            case destructive
        }

        let id: String
        let title: String
        let role: Role?
        let handler: (() -> Void)?

        public init(id: String = UUID().uuidString, title: String, role: Role? = nil, handler: (() -> Void)? = nil) {
            self.id = id
            self.title = title
            self.role = role
            self.handler = handler
        }

        public static func == (lhs: ConfirmationDialogInputData.Action, rhs: ConfirmationDialogInputData.Action) -> Bool {
            lhs.id == rhs.id
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

    }

    let message: String?
    let actions: [Action]

    public init(message: String? = nil, actions: [Action]) {
        self.message = message
        self.actions = actions
    }

}

public final class ConfirmationDialogNavigationNode: NavigationNode {

    let inputData: ConfirmationDialogInputData
    let sourceID: String?

    init(inputData: ConfirmationDialogInputData, sourceID: String?) {
        self.inputData = inputData
        self.sourceID = sourceID
    }

}


public struct ConfirmationDialogPresentedNavigationNode: PresentedNavigationNode {

    public let node: NavigationNode

    public init(inputData: ConfirmationDialogInputData, sourceID: String? = nil) {
        self.node = ConfirmationDialogNavigationNode(inputData: inputData, sourceID: sourceID)
    }

    public static func presenterResolvedViewModifier(resolvedViewNode: NavigationNode, content: AnyView, id: String?) -> some View {
        content
            .confirmationDialog(
                Text(""),
                isPresented: Binding(
                    get: {
                        if resolvedViewNode.presentedNode?.node is ConfirmationDialogNavigationNode,
                        id == (resolvedViewNode.presentedNode?.node as? ConfirmationDialogNavigationNode)?.sourceID {
                            true
                        } else {
                            false
                        }
                    },
                    set: { isPresented in
                        guard !isPresented else { return }
                        resolvedViewNode.presentedNode = nil
                    }
                ),
                actions: {
                    ForEach((resolvedViewNode.presentedNode?.node as? ConfirmationDialogNavigationNode)?.inputData.actions ?? [], id: \.id) { action in
                        Button(
                            action.title,
                            role: {
                                switch action.role {
                                case .cancel:
                                    .cancel
                                case .destructive:
                                    .destructive
                                case .none:
                                    .none
                                }
                            }(),
                            action: { action.handler?() }
                        )
                    }
                },
                message: {
                    if let message = (resolvedViewNode.presentedNode?.node as? ConfirmationDialogNavigationNode)?.inputData.message {
                        Text(message)
                    }
                }
            )
    }

}

public protocol PresentedNavigationNode {
    associatedtype Body: View
    var node: NavigationNode { get }
    @MainActor
    static func presenterResolvedViewModifier(resolvedViewNode: NavigationNode, content: AnyView, id: String?) -> Body
}

@MainActor
protocol NavigationNodeResolvedViewModifier {
    associatedtype Body: View
    func body(content: AnyView) -> Body
}

import SwiftUI

/// Use this `View` directly just when you do need to wrap some model as child to other model
public struct NavigationModelResolvedView: View {

    @ObservedObject private var model: AnyNavigationModel
    @Environment(\.self) private var environment
    @Environment(\.navigationEnvironmentTriggerHandler) private var environmentTriggerHandler

    public init(model: any NavigationModel) {
        self.model = AnyNavigationModel(model)
        bindParentLogic(children: model.children) // TODO: Replace with onChange(of:initial:_:) for iOS 17
    }

    public var body: some View {
        model.body
            .presentingNavigationSource(id: nil)
            .onReceive(model.commonState.navigationEnvironmentTrigger) { environmentTriggerHandler.handleTrigger($0, in: environment) }
            .onChange(of: equatableModelChildren) { [oldChildren = equatableModelChildren] newChildren in
                bindSendingRemovalMessages(
                    newChildren: newChildren.compactMap(\.wrapped),
                    oldChildren: oldChildren.compactMap(\.wrapped)
                )
            }
            .onChange(of: equatableModelChildren) { bindParentLogic(children: $0.compactMap(\.wrapped)) }
            .environmentObject(model)
    }

    private var equatableModelChildren: [EquatableNavigationModel] {
        modelChildren.map { EquatableNavigationModel(wrapped: $0) }
    }

    private var modelChildren: [any NavigationModel] {
        model.children
    }

    private func bindSendingRemovalMessages(
        newChildren: [any NavigationModel],
        oldChildren: [any NavigationModel]
    ) {
        let removedChildren = oldChildren.filter { oldChild in
            !newChildren.contains(where: { oldChild === $0 })
        }
        removedChildren.forEach { child in
            child.successorsIncludingSelf.forEach { model in
                model.finishIfNeeded()
            }
        }
    }

    private func bindParentLogic(children: [any NavigationModel]) {
        children.forEach { child in
            Task { @MainActor in
                await child.startIfNeeded(parent: model.base)
            }
        }
    }

}

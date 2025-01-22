public struct TabsSelectItemNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        selectItem(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains(where: { $0.state is TabsRootNavigationNodeState })
    }

    private let itemID: AnyHashable

    public init(itemID: AnyHashable) {
        self.itemID = itemID
    }

    private func selectItem(on node: any NavigationNode) {
        guard let state = node.state as? TabsRootNavigationNodeState else {
            if let parent = node.parent {
                return selectItem(on: parent)
            } else {
                return
            }
        }
        guard let newSelectedNode = state.tabsNodes.first(where: { $0.id == itemID }) else { return }
        state.selectedTabNode = newSelectedNode
    }

}

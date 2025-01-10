public struct TabsSelectItemNavigationCommand: NavigationCommand {

    public func execute(on node: NavigationNode) {
        selectItem(on: node)
    }

    public func canExecute(on node: NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains(where: { $0 is TabsRootNavigationNode })
    }

    private let itemID: AnyHashable

    public init(itemID: AnyHashable) {
        self.itemID = itemID
    }

    private func selectItem(on node: NavigationNode) {
        guard let node = node as? TabsRootNavigationNode else {
            if let parent = node.parent {
                return selectItem(on: parent)
            } else {
                return
            }
        }
        guard let newSelectedNode = node.tabsNodes.first(where: { $0.id == itemID }) else { return }
        node.selectedTabNode = newSelectedNode
    }

}

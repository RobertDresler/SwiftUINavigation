public struct TabsSelectItemNavigationCommand: NavigationCommand {

    public func execute(on node: any NavigationNode) {
        selectItem(on: node)
    }

    public func canExecute(on node: any NavigationNode) -> Bool {
        node.predecessorsIncludingSelf.contains(where: { $0 is any TabsRootNavigationNode })
    }

    private let itemID: AnyHashable

    public init(itemID: AnyHashable) {
        self.itemID = itemID
    }

    private func selectItem(on node: any NavigationNode) {
        guard let node = node as? any TabsRootNavigationNode else {
            if let parent = node.parent {
                return selectItem(on: parent)
            } else {
                return
            }
        }
        guard node.tabsNodes.contains(where: { $0.id == itemID }) else {
            assertionFailure("There is no TabNode in tabsNodes with id: \(itemID)")
            return
        }
        node.selectedTabNodeID = itemID
    }

}

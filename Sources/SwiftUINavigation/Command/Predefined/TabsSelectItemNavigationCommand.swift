public struct TabsSelectItemNavigationCommand: NavigationCommand {

    public func execute(on model: any NavigationModel) {
        selectItem(on: model)
    }

    public func canExecute(on model: any NavigationModel) -> Bool {
        model.predecessorsIncludingSelf.contains(where: { $0 is any TabsRootNavigationModel })
    }

    private let itemID: AnyHashable

    public init(itemID: AnyHashable) {
        self.itemID = itemID
    }

    private func selectItem(on model: any NavigationModel) {
        guard let model = model as? any TabsRootNavigationModel else {
            if let parent = model.parent {
                return selectItem(on: parent)
            } else {
                return
            }
        }
        guard model.tabsModels.contains(where: { $0.id == itemID }) else {
            assertionFailure("There is no TabModel in tabsModels with id: \(itemID)")
            return
        }
        model.selectedTabModelID = itemID
    }

}

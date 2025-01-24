public extension PresentedNavigationNode where Self == FullScreenCoverPresentedNavigationNode {
    static func fullScreenCover(_ node: any NavigationNode) -> FullScreenCoverPresentedNavigationNode {
        FullScreenCoverPresentedNavigationNode(node: node)
    }
}

public extension PresentedNavigationNode where Self == SheetPresentedNavigationNode {
    static func sheet(_ node: any NavigationNode, sourceID: String? = nil) -> SheetPresentedNavigationNode {
        SheetPresentedNavigationNode(node: node, sourceID: sourceID)
    }
}

public extension PresentedNavigationNode where Self == AlertPresentedNavigationNode {
    static func alert(_ inputData: AlertInputData, sourceID: String? = nil) -> AlertPresentedNavigationNode {
        AlertPresentedNavigationNode(inputData: inputData, sourceID: sourceID)
    }
}

public extension PresentedNavigationNode where Self == ConfirmationDialogPresentedNavigationNode {
    static func confirmationDialog(
        _ inputData: ConfirmationDialogInputData,
        sourceID: String? = nil
    ) -> ConfirmationDialogPresentedNavigationNode {
        ConfirmationDialogPresentedNavigationNode(inputData: inputData, sourceID: sourceID)
    }
}

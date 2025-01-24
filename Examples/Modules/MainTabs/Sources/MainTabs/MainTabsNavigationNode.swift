import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ActionableList

@TabsRootNavigationNode
public final class MainTabsNavigationNode {

    public init(inputData: MainTabsInputData) {
        let commandsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.commands,
            image: Image(systemName: "square.grid.2x2"),
            title: "Commands",
            navigationNode: .stacked(ActionableListNavigationNode(inputData: .default))
        )
        let flowsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.flows,
            image: Image(systemName: "point.topright.filled.arrow.triangle.backward.to.point.bottomleft.scurvepath"),
            title: "Flows",
            navigationNode: .stacked(ActionableListNavigationNode(inputData: ActionableListInputData(id: .flows)))
        )
        let tabsNodes = [
            commandsTab,
            flowsTab
        ]
        state = TabsRootNavigationNodeState(
            selectedTabNode: tabsNodes.first(where: { $0.id == inputData.initialTab }) ?? commandsTab,
            tabsNodes: tabsNodes
        )
    }

}

import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ActionableList

public final class MainTabsNavigationNode: TabsRootNavigationNode {

    public init(inputData: MainTabsInputData) {
        let commandsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.commands,
            image: Image(systemName: "square.grid.2x2"),
            title: "Commands",
            navigationNode: StackRootNavigationNode(
                stackNodes: [
                    StackNavigationNode(
                        destination: ActionableListNavigationNode(
                            inputData: .default
                        ),
                        transition: nil
                    )
                ]
            )
        )
        let flowsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.flows,
            image: Image(systemName: "point.topright.filled.arrow.triangle.backward.to.point.bottomleft.scurvepath"),
            title: "Flows",
            navigationNode: StackRootNavigationNode(
                stackNodes: [
                    StackNavigationNode(
                        destination: ActionableListNavigationNode(
                            inputData: ActionableListInputData(id: .flows)
                        ),
                        transition: nil
                    )
                ]
            )
        )
        let tabsNodes = [
            commandsTab,
            flowsTab
        ]
        super.init(
            selectedTabNode: tabsNodes.first(where: { $0.id == inputData.initialTab }) ?? commandsTab,
            tabsNodes: tabsNodes
        )
    }

}

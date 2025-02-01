import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ActionableList

@TabsRootNavigationNode
public final class MainTabsNavigationNode {

    public var selectedTabNodeID: AnyHashable
    public var tabsNodes: [any TabNode]

    public init(inputData: MainTabsInputData) {
        let commandsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.commands,
            image: Image(systemName: "square.grid.2x2"),
            title: "Commands",
            navigationNode: .stacked(
                ActionableListNavigationNode(inputData: .default),
                tabBarToolbarBehavior: .hiddenWhenNotRoot(animated: true)
            )
        )
        let flowsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.flows,
            image: Image(systemName: "point.topright.filled.arrow.triangle.backward.to.point.bottomleft.scurvepath"),
            title: "Flows",
            navigationNode: .stacked(
                ActionableListNavigationNode(inputData: ActionableListInputData(id: .flows)),
                tabBarToolbarBehavior: .hiddenWhenNotRoot(animated: true)
            )
        )
        selectedTabNodeID = inputData.initialTab
        tabsNodes = [
            commandsTab,
            flowsTab
        ]
    }

    public func body(for content: TabsRootNavigationNodeView<MainTabsNavigationNode>) -> some View {
        content
    }

}

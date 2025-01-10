import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ActionableList
import Settings

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
        let settingsTab = DefaultTabNode(
            id: MainTabsInputData.Tab.settings,
            image: Image(systemName: "gearshape.fill"),
            title: "Settings",
            navigationNode: StackRootNavigationNode(
                stackNodes: [
                    StackNavigationNode(
                        destination: SettingsNavigationNode(
                            inputData: SettingsInputData()
                        ),
                        transition: nil
                    )
                ]
            )
        )
        let tabsNodes = [
            commandsTab,
            settingsTab
        ]
        super.init(
            selectedTabNode: tabsNodes.first(where: { $0.id == inputData.initialTab }) ?? commandsTab,
            tabsNodes: tabsNodes
        )
    }

}

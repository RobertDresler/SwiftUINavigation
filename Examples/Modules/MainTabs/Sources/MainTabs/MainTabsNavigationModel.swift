import SwiftUI
import SwiftUINavigation
import ExamplesNavigation
import ActionableList
import DeepLinkForwarderService
import NotificationsService
import FlagsRepository

@TabsRootNavigationModel
public final class MainTabsNavigationModel {

    public var selectedTabModelID: AnyHashable
    public var tabsModels: [any TabModel]

    public init(
        inputData: MainTabsInputData,
        deepLinkForwarderService: DeepLinkForwarderService,
        notificationsService: NotificationsService,
        flagsRepository: FlagsRepository
    ) {
        let commandsTab = DefaultTabModel(
            id: MainTabsInputData.Tab.commands,
            image: Image(systemName: "square.grid.2x2"),
            title: "Commands",
            navigationModel: .stacked(
                ActionableListNavigationModel(
                    inputData: .default,
                    deepLinkForwarderService: deepLinkForwarderService,
                    notificationsService: notificationsService,
                    flagsRepository: flagsRepository
                ),
                tabBarToolbarBehavior: .hiddenWhenNotRoot(animated: true)
            )
        )
        let flowsTab = DefaultTabModel(
            id: MainTabsInputData.Tab.flows,
            image: Image(systemName: "point.topright.filled.arrow.triangle.backward.to.point.bottomleft.scurvepath"),
            title: "Flows",
            navigationModel: .stacked(
                ActionableListNavigationModel(
                    inputData: ActionableListInputData(id: .flows),
                    deepLinkForwarderService: deepLinkForwarderService,
                    notificationsService: notificationsService,
                    flagsRepository: flagsRepository
                ),
                tabBarToolbarBehavior: .hiddenWhenNotRoot(animated: true)
            )
        )
        selectedTabModelID = inputData.initialTab
        tabsModels = [
            commandsTab,
            flowsTab
        ]
    }

    public func body(for content: TabsRootNavigationModelView<MainTabsNavigationModel>) -> some View {
        content
    }

}

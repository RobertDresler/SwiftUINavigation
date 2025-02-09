import SwiftUINavigation
import Shared

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationModel` methods from the `View` or pass events to the `NavigationModel`. Check examples in **Architectures** flow for the correct approach.
struct ModalsTraditionalActionableListDataFactory: ActionableListDataFactory {

    var deepLinkForwarderService: DeepLinkForwarderService
    var notificationsService: NotificationsService
    var flagsRepository: FlagsRepository
    
    func makeTitle() -> String {
        "Modals - Traditional"
    }
    
    func makeItems() -> [ActionableListItem] {
        [
            presentFullScreenCoverItem,
            presentFullScreenCoverWithoutAnimationItem,
            presentSheetItem,
            presentBottomSheetItem,
            dismissItem
        ]
    }

    private var presentFullScreenCoverItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus.fill",
                accentColor: .blue,
                title: "Present Full Screen Cover"
            ),
            makeCommand: {
                .present(
                    .fullScreenCover(
                        .stacked(
                            ActionableListNavigationModel(
                                inputData: .default,
                                deepLinkForwarderService: deepLinkForwarderService,
                                notificationsService: notificationsService,
                                flagsRepository: flagsRepository
                            )
                        )
                    )
                )
            }
        )
    }

    private var presentFullScreenCoverWithoutAnimationItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.portrait.badge.plus",
                accentColor: .blue,
                title: "Present Full Screen Cover",
                subtitle: "Without Animation"
            ),
            makeCommand: {
                .present(
                    .fullScreenCover(
                        .stacked(
                            ActionableListNavigationModel(
                                inputData: .default,
                                deepLinkForwarderService: deepLinkForwarderService,
                                notificationsService: notificationsService,
                                flagsRepository: flagsRepository
                            )
                        )
                    ),
                    animated: false
                )
            }
        )
    }

    private var presentSheetItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "rectangle.stack.fill.badge.plus",
                accentColor: .blue,
                title: "Present Sheet"
            ),
            makeCommand: {
                .present(
                    .sheet(
                        .stacked(
                            ActionableListNavigationModel(
                                inputData: .default,
                                deepLinkForwarderService: deepLinkForwarderService,
                                notificationsService: notificationsService,
                                flagsRepository: flagsRepository
                            )
                        )
                    )
                )
            }
        )
    }

    private var presentBottomSheetItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "inset.filled.bottomhalf.rectangle.portrait",
                accentColor: .blue,
                title: "Present Sheet",
                subtitle: "...with Medium detent (Bottom Sheet)"
            ),
            makeCommand: {
                .present(
                    .sheet(
                        .stacked(
                            ActionableListNavigationModel(
                                inputData: ActionableListInputData(
                                    id: .commands,
                                    addPresentationDetents: true
                                ),
                                deepLinkForwarderService: deepLinkForwarderService,
                                notificationsService: notificationsService,
                                flagsRepository: flagsRepository
                            )
                        )
                    )
                )
            }
        )
    }

    private var dismissItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "xmark.circle",
                accentColor: .blue,
                title: "Dismiss"
            ),
            makeCommand: {
                .dismiss()
            }
        )
    }


}

import SwiftUINavigation
import ExamplesNavigation
import SwiftUI

struct URLHandlingActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "URL Handling"
    }
    
    func makeItems() -> [ActionableListItem] {
        [
            openURLItem,
            sfSafariItem,
            appSettingsItem
        ]
    }

    private var openURLItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "link",
                accentColor: .brown,
                title: "Open URL",
                subtitle: "...and let the system take care of the rest"
            ),
            makeCommand: {
                OpenURLNavigationCommand(
                    url: URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")! /// Don’t unwrap this in practice — unless you’re into playing with fire.
                )
            }
        )
    }

    private var sfSafariItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "safari.fill",
                accentColor: .brown,
                title: "Open URL",
                subtitle: "...in SFSafari (note that SFSafariNavigationNode utilizes UIViewControllerRepresentable)"
            ),
            makeCommand: {
                PresentNavigationCommand(
                    presentedNode: SheetPresentedNavigationNode.standalone(
                        node: SFSafariNavigationNode(
                            inputData: SFSafariInputData(url: URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!) /// Don’t unwrap this in practice — unless you’re into playing with fire.
                        )
                    )
                )
            }
        )
    }

    private var appSettingsItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "gear",
                accentColor: .brown,
                title: "Go to App Settings"
            ),
            makeCommand: {
                OpenURLNavigationCommand(
                    url: URL(string: UIApplication.openSettingsURLString)! /// Don’t unwrap this in practice — unless you’re into playing with fire.
                )
            }
        )
    }

}

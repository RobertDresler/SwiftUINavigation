import SwiftUINavigation
import SwiftUI

/// NOTE: Avoid placing commands directly in the `View`, like in `ActionableListView`. This is for simplified demonstration purposes. Instead, call `NavigationModel` methods from the `View` or pass events to the `NavigationModel`. Check examples in **Architectures** flow for the correct approach.
struct URLHandlingActionableListDataFactory: ActionableListDataFactory {

    func makeTitle() -> String {
        "URL Handling"
    }
    
    func makeItems() -> [ActionableListItem] {
        #if os(iOS)
        [
            openURLItem,
            sfSafariItem,
            appSettingsItem
        ]
        #else
        [
            openURLItem
        ]
        #endif
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
                .openURL(URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!) /// Don’t unwrap this in practice — unless you’re into playing with fire.
            }
        )
    }

    #if os(iOS)
    private var sfSafariItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "safari.fill",
                accentColor: .brown,
                title: "Open URL",
                subtitle: "...in SFSafari (note that SFSafariNavigationModel utilizes UIViewControllerRepresentable)"
            ),
            makeCommand: {
                .present(
                    .sheet(
                        SFSafariNavigationModel(
                            inputData: SFSafariInputData(url: URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!) /// Don’t unwrap this in practice — unless you’re into playing with fire.
                        )
                    )
                )
            }
        )
    }
    #endif

    #if os(iOS)
    private var appSettingsItem: ActionableListItem {
        .new(
            viewModel: ActionableListItemView.ViewModel(
                symbolName: "gear",
                accentColor: .brown,
                title: "Go to App Settings"
            ),
            makeCommand: {
                .openURL(URL(string: UIApplication.openSettingsURLString)!) /// Don’t unwrap this in practice — unless you’re into playing with fire.
            }
        )
    }
    #endif

}

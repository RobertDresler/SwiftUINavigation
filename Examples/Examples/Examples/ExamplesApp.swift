//
//  ExamplesApp.swift
//  Examples
//
//  Created by Robert Dresler on 23.10.2024.
//

import SwiftUI
import SwiftData
import SwiftUINavigation
import ExamplesNavigation
import ExamplesNavigationResolving

@main
struct ExamplesApp: App {

    var body: some Scene {
        WindowGroup {
            SwiftUINavigationWindow(
                root: ExamplesNavigationDeepLink(destination: .app(AppInputData())),
                resolver: ExamplesNavigationDeepLinkResolver()
            )
        }
    }

}

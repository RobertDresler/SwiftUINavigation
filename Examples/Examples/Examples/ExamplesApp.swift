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
import UserRepository

@main
struct ExamplesApp: App {

    private let userRepository = UserRepository()

    var body: some Scene {
        WindowGroup {
            SwiftUINavigationWindow(
                resolver: ExamplesNavigationDeepLinkResolver(),
                rootDeepLink: ExamplesNavigationDeepLink(
                    destination: .root(ExamplesNavigationDeepLink(destination: .app(AppInputData())))
                )
            ).environmentObject(userRepository)
        }
    }

}

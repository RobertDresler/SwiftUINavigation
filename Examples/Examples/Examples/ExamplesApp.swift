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
                //rootDeepLink: ExamplesNavigationDeepLink(destination: .app(AppInputData())),
                resolver: ExamplesNavigationDeepLinkResolver(),
                switchedDeepLinkResolver: MainAppSwitchedDeepLinkResolver(userRepository: userRepository)
            ).environmentObject(userRepository)
        }
    }

}

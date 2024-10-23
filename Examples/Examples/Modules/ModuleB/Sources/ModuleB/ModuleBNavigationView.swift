//
//  ModuleBNavigationView.swift
//  ModuleB
//
//  Created by Robert Dresler on 23.10.2024.
//


import SwiftUI
import SwiftUINavigation
import ExamplesNavigation

public struct ModuleBNavigationView: View {

    @EnvironmentObject private var pathHolder: CustomNavigationStackPathHolder<ExamplesNavigationDeepLink>
    private let inputData: ModuleBInputData

    public init(inputData: ModuleBInputData) {
        self.inputData = inputData
    }

    public var body: some View {
        ModuleBView(
            inputData: inputData,
            executeNavigationCommand: { pathHolder.executeCommand($0) }
        )
    }
}

//
//  NavigationNode 2.swift
//  SwiftUINavigation
//
//  Created by Robert Dresler on 22.01.2025.
//


import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct TabsRootNavigationNode: ExtensionMacro, MemberMacro, MemberAttributeMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        [
            AttributeSyntax("@MainActor")
        ]
    }

    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let accessModifier = declaration.modifiers.first {
            [.keyword(.public), .keyword(.package)].contains($0.name.tokenKind)
        }
        return [
            DeclSyntax(
                """
                @MainActor \(accessModifier)let state: TabsRootNavigationNodeState
                
                @MainActor \(accessModifier) var body: some View {
                    TabsRootNavigationNodeView()
                }
                """
            )
        ]
    }

    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        let accessModifier = declaration.modifiers.first {
            [.keyword(.open), .keyword(.public), .keyword(.package)].contains($0.name.tokenKind)
        }
        return [
            try ExtensionDeclSyntax("@MainActor extension \(type.trimmed): NavigationNode {}")
        ]
    }
}

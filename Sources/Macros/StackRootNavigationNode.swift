import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct StackRootNavigationNode: ExtensionMacro, MemberMacro, MemberAttributeMacro {
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
                @MainActor \(accessModifier) var body: some View {
                    body(for: StackRootNavigationNodeView())
                }

                \(accessModifier) let state: StackRootNavigationNodeState
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
        [
            try ExtensionDeclSyntax("@MainActor extension \(type.trimmed): NavigationNode {}"),
            try ExtensionDeclSyntax("@MainActor extension \(type.trimmed): ModifiableStackRootNavigationNode {}")
        ]
    }
}

import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct NavigationModel: ExtensionMacro, MemberMacro, MemberAttributeMacro {
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        let commonAttributes = [AttributeSyntax("@MainActor")]
        guard let variableDecl = member.as(VariableDeclSyntax.self) else { return commonAttributes }
        let hasExplicitGetter = variableDecl.bindings.contains { $0.accessorBlock != nil }
        let isLetDeclaration = variableDecl.bindingSpecifier.text == "let"
        let isLazy = variableDecl.modifiers.contains { $0.name.text == "lazy" }
        guard !hasExplicitGetter, !isLetDeclaration, !isLazy else { return commonAttributes }
        return commonAttributes + [AttributeSyntax("@Published")]
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
                \(accessModifier) let commonState = CommonNavigationModelState()
                \(accessModifier) let id = UUID().uuidString
                deinit {
                    printDebugText("Finished")
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
            try ExtensionDeclSyntax("@MainActor extension \(type.trimmed): NavigationModel {}")
        ]
    }
}

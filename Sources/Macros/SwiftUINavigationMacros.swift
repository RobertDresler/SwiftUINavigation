import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct SwiftUINavigationMacros: CompilerPlugin {

    var providingMacros: [Macro.Type] = [
        NavigationNode.self,
        TabsRootNavigationNode.self,
        SwitchedNavigationNode.self,
        StackRootNavigationNode.self
    ]

}

import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct SwiftUINavigationMacros: CompilerPlugin {

    var providingMacros: [Macro.Type] = [
        NavigationModel.self,
        TabsRootNavigationModel.self,
        SwitchedNavigationModel.self,
        StackRootNavigationModel.self
    ]

}
